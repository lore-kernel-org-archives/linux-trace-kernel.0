Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AD944B686;
	Thu, 22 Jan 2026 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096633; cv=none; b=O0PpLUap6x0xKJ6jct1w7r5hcaATKGgcpd/CS/eHND40sIDA4gOB6aiZeB5ZZBs+oW18SLLL9q32SurumpxtnyYGQo0b4Jyx0rJsKXZZ68yPbkQCLlurtDa7OvjmelxFOQzNbVEVoI2NJDpJXtnd2bcz7w8icic6R6Lh2WivS/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096633; c=relaxed/simple;
	bh=C5XwhY1lBp6rzGALe6rRFsEZb8OxRWva9atQGFrE4EE=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bmfhBMG/FvwnvVA1xc9661hPnTHUwTkS4O596Zr2aJ1JvKvPItR604LEZDmuC4K3jGIFhGwxcStvmFPTPpksdaVvJ/heBk+stSqznmRjBYp7ktgWcLG8y6bwem6p4SfUJfWcVXUvGsi0K3OTre1h9/sW1kPItU7+c1earJzg4wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PmvKmHw8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/pG8Y3OJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PmvKmHw8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/pG8Y3OJ"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769096618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C5XwhY1lBp6rzGALe6rRFsEZb8OxRWva9atQGFrE4EE=;
	b=PmvKmHw8/YHW9ll1kfVqdCr/8zjhL/JgRkfCcrMie9shYrYGAwEdU4fIKVFjbYNXrqDlHa
	hXrUVJnGC400BLSfiH6QLOEB3zugJp1rTpNnkx5fy0Ly+zzwzYFN6gwPzyKZ604cyPMxB4
	eurUt/kc/Qj6P4aeadwgzXOKA6xeTi1exn+5MmlO/Pmk/4AHL6ay/NWuDZjhRZ6xN1Si9f
	Q0anZXKAU/96GjyjdnuVdYzqRM/fE3oZ13hIjYzifWbgwPF21+5hrVeJzrOqIuj3m4GU/R
	vw1LhfGLgteJhrsoddYMnzMd9N4YhGumspwsN/UNIeBb9WBOUAXOIvyd4t+q1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769096618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C5XwhY1lBp6rzGALe6rRFsEZb8OxRWva9atQGFrE4EE=;
	b=/pG8Y3OJoH4SPUpcHNWmFiSFXsn8RrlE1Cq3N6P03EgIwWooaLuyYOFsinM8v3aYn7YIuu
	mEBnwYcgEkHUEjAw==
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, Wander
 Lairson Costa <wander@redhat.com>, open list
 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION (RV)"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 23/26] rv/rvgen: add type annotations to fix pyright errors
In-Reply-To: <20260119205601.105821-24-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-24-wander@redhat.com>
Date: Thu, 22 Jan 2026 16:43:38 +0100
Message-ID: <87343xirf9.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wander Lairson Costa <wander@redhat.com> writes:

> Add return type annotations to RVGenerator base class methods and
> LTL operator classes to resolve pyright reportIncompatibleMethodOverride
> errors.
>
> In generator.py, add string return type annotations to all template
> filling methods and annotate the template_dir class attribute to enable
> proper type checking during initialization.
>
> In ltl2ba.py, introduce a LTLNode type alias as a Union of all AST node
> types (BinaryOp, UnaryOp, Variable, Literal) to properly type operator
> transformations. The operator base classes BinaryOp and UnaryOp receive
> return type annotations using this type alias for their normalize and
> negate methods, since these transformations can return different node
> types depending on the expression. The Variable and Literal classes gain
> return type annotations for their manipulation methods, and all temporal
> checking methods are annotated to return bool.
>
> The LTLNode type alias is necessary because operator transformations are
> polymorphic: NotOp.negate() can return BinaryOp, UnaryOp, Variable, or
> Literal depending on what expression is being negated.
>
> In ltl2k.py, fix the _fill_states return type from str to list[str] to
> match the actual implementation.
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
