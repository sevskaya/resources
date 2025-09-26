let minSize = 1.0;
let maxSize = 1.5;
let currentSize = 1.0;

// Inicialmente esconde a interface
document.body.style.display = 'none';

window.addEventListener('message', function(event) {
    if (event.data.type === 'open') {
        minSize = event.data.min;
        maxSize = event.data.max;
        currentSize = event.data.current;
        
        // Atualiza o slider com os novos limites
        const slider = document.getElementById('sizeSlider');
        slider.min = 0;
        slider.max = 100;
        slider.value = 50;
        
        // Atualiza o texto do tamanho atual
        updateSize(50);
        
        // Mostra a interface
        document.body.style.display = 'flex';
    } else if (event.data.type === 'close') {
        document.body.style.display = 'none';
    }
});

function updateSize(value) {
    const percentage = value / 100;
    let newSize = minSize + (maxSize - minSize) * percentage;
    
    // Evita que o tamanho seja exatamente 1.0
    if (Math.abs(newSize - 1.0) < 0.01) {
        newSize = newSize < 1.0 ? 0.99 : 1.01;
    }
    
    currentSize = newSize;
    document.getElementById('currentSize').textContent = currentSize.toFixed(2);
    
    fetch(`https://${GetParentResourceName()}/updateSize`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            size: currentSize
        })
    });
}

document.getElementById('sizeSlider').addEventListener('input', function(e) {
    updateSize(e.target.value);
});

document.getElementById('applyBtn').addEventListener('click', function() {
    // Verificação final antes de aplicar
    if (Math.abs(currentSize - 1.0) < 0.01) {
        currentSize = currentSize < 1.0 ? 0.99 : 1.01;
    }
    
    fetch(`https://${GetParentResourceName()}/applySize`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            size: currentSize
        })
    });
    document.body.style.display = 'none';
});

document.getElementById('cancelBtn').addEventListener('click', function() {
    fetch(`https://${GetParentResourceName()}/cancel`, {
        method: 'POST'
    });
    document.body.style.display = 'none';
}); 