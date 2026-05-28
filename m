Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AE53876CA;
	Thu, 28 May 2026 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958097; cv=none; b=C7uY/obVNvSlitn0p565cM4Rh7dqVSVK+5+s5rFTE+2jgAOswsjHNWmgFP/Q0gMxUKBKzwyCM7INN0tauGpFogenxXwZ7d9rmJ9tYzTfpKaGbDm33mw2pNOP2bc5VtbHpPb8RItwDs16lbe42CnKdWePXt1Up7FWNOXS4Xgde1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958097; c=relaxed/simple;
	bh=hztMGMWeHdjF4tXqb02tll1uVp05kRSwPdqRByt0HKc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qq+RejTt6ozpLqBic0swaOLfqjfgsVLeNmEfXxclcAAnzw6HYdc1sxrSB6DlUqIsgmmssXIKYiwlzpUtgEUOT6h0EjpCA/wIlJuEHwhlyvQ7Lqi6mLb+3PfbqvMv+ROvWQhUPK1o/V3iAZ2riU/mZ6d55n018h9Ln+G31QTwQHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ss5ytF80; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J4aH4M4I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ss5ytF80";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J4aH4M4I"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779958094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8fY0MKnqviYgDlPdRmNARfoXIvl9c2Gx/pZM6HLqALU=;
	b=ss5ytF80LpxPwxsD4NpxQo2HXIputkqxTDpRmr1bL746OLcBgA+iNyiCYVbWXS75U7d4Ts
	jWrDSfC9XfmsmjcokMt8HVfMzihdf1G27SUaqRJxqyBLqCNgTDp+s6Nbm5iVsJJEL78eU7
	duk5JXk2pos8EHOXvV2L0wIG211I1n4NN8LkYEgG8Mv7M3oSnUtxLBsehZX3cT0WvAmoAu
	CWIjywzJWui741ZAKHAJQ28lxx0iwdurkulD8+GlHO2vxqXdwf0gMYKhYa54cCzip06cKy
	lktpiunjFshmbhAmt94ELGj6b6ujYwL/3j+B9j/w96kd1wwfWvwdlzGiSGn42g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779958094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8fY0MKnqviYgDlPdRmNARfoXIvl9c2Gx/pZM6HLqALU=;
	b=J4aH4M4Iyc+tK/Zqey2i0Q1H2EvbVh4ZPltTa9x5rQk789nKlfsYT8XDDpZ5scyEgDD2KS
	JgFVjBqSyT/5MkDw==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH v2 03/12] rv: Reset per-task DA monitors before
 releasing the slot
In-Reply-To: <20260527062313.39908-4-gmonaco@redhat.com>
References: <20260527062313.39908-1-gmonaco@redhat.com>
 <20260527062313.39908-4-gmonaco@redhat.com>
Date: Thu, 28 May 2026 10:48:13 +0200
Message-ID: <87ik87or76.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Per-task monitors use task_mon_slot to determine which slot in the array
> to use for the monitor. During destruction, this slot is returned but
> this is done before resetting the monitor. As a result, the monitor's
> reset is in fact resetting a slot that is outside of the array
> (RV_PER_TASK_MONITOR_INIT).

Oh crap.

> Release the slot only after the reset to avoid out-of-bound memory
> access.

I think KASAN can catch this type of issue.

> Fixes: f5587d1b6ec93 ("rv: Add Hybrid Automata monitor type")
> Suggested-by: Wen Yang <wen.yang@linux.dev>
> Reviewed-by: Wen Yang <wen.yang@linux.dev>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Should we have
  Cc: stable@vger.kernel.org
?

Reviewed-by: Nam Cao <namcao@linutronix.de>
