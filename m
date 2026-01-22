Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984E0492527;
	Thu, 22 Jan 2026 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097238; cv=none; b=r5+FDYdcB+TwJIO4fjfbF89auGbGxsPkHyThGfeiqemd3JneO1box6WQNlMNzLggSnRPhrcDgFmLckiR5T4CWjCb41we1RBAwrFupmDlpFklB3FSVBjzZ9W0+Ikmqv97w2Wmpftqyur9QIvAar6vSXG1j78xhqRNiDYFJGyNPME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097238; c=relaxed/simple;
	bh=UdD5EQMZkh06GpFykFZuOCAXx2c54ukn2JafiyiIOR4=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mAY49CTfAuot78wiOtj1m7Lkiphf2aqBWJ77Noqhc5Coi6oifGRP5Tb9XnvdD4K8joP7CYFP1UXV2JnzP+GKDuT5nMTBoduH70jVWihb4jnIIzH/B/cKHu4l2A7Hd3WIA/2dKlhGOU876Bouv/e9DKoGnLNRluJD5cBkxnGyAL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q5riEGHj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gudqM0n7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q5riEGHj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gudqM0n7"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769097231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UdD5EQMZkh06GpFykFZuOCAXx2c54ukn2JafiyiIOR4=;
	b=q5riEGHjJGpyWqS1Qq9d3dqe06nIEHirpXeB6T73n/OtBYhbElfPGU07WRJfaIm99zA/dh
	J+e5oIxQhhC/HAF+36z1KZr9XYLrGIio2Dtr32Ueoq/ZsKm4rSx3gk4TjO08yIoz0TUNS+
	CQC6nKTTNwsHFtUc4KAK/wU8Sb3i5ZRuRkyBGftbKYLcvWBQrUvEQEz4IrotuxR4Ksc+mz
	Yfa9ca+oKoCNmBUeD6Wl2DzLwTSYEBprJ6YOXh36QWyCCacH/kxzEc2MfoRIsaFQKGECXc
	598Aj2hhqIAmL1OTihDbS8loi31uIeGnFvef6x4sI0lGD1zaaL3+Dk4kFAzAVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769097231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UdD5EQMZkh06GpFykFZuOCAXx2c54ukn2JafiyiIOR4=;
	b=gudqM0n7a7g9JEsDQKdUn9ctFAHDnZklW3HEqdYXzIvWjiBJZMUwwkoO4+opy+YlzI2DY9
	kBW3fi7YyTiWKwDg==
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, Wander
 Lairson Costa <wander@redhat.com>, open list
 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION (RV)"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 25/26] rv/rvgen: fix isinstance check in Variable.expand()
In-Reply-To: <20260119205601.105821-26-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-26-wander@redhat.com>
Date: Thu, 22 Jan 2026 16:53:51 +0100
Message-ID: <87wm19hcds.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wander Lairson Costa <wander@redhat.com> writes:
> The Variable.expand() method in ltl2ba.py performs contradiction
> detection by checking if a negated variable already exists in the
> graph node's old set. However, the isinstance check was incorrectly
> testing the ASTNode wrapper instead of the wrapped operator, causing
> the check to always return False.
>
> The old set contains ASTNode instances which wrap LTL operators via
> their .op attribute. The fix changes isinstance(f, NotOp) to
> isinstance(f.op, NotOp) to correctly examine the wrapped operator
> type. This follows the established pattern used elsewhere in the
> file, such as the iteration at lines 572-574 which accesses
> o.op.is_temporal() on items from node.old.
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

These isinstance() usages deserve to be buried. But I'm not sure yet how
to replace them. So, for now:

Reviewed-by: Nam Cao <namcao@linutronix.de>
