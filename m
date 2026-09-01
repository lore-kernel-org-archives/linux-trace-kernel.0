Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3709D36E467
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 03:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788232239; cv=none; b=H5cqQpGa10t90qXG8x7ekbPjhW0vDA0f7D15/DfThTTSmfOOcTncl8gYTv9nanCRqK1c0QHue9DLYwhp4K4YAkRhq6d5wehvOPCAGI17ajq3rMIZ7mO2b332XzRZUG6knu+5wNPwN0Ife1g1LDAjnLcdJoApF3guw8FheiQnddo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788232239; c=relaxed/simple;
	bh=ENw7urg0+GVpzz2A949PwjF8i3RAVOxo5v//+QnGY0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jtr6ko2sj/7WQyqysc+PBYmZ/fDa7GLN/njci03BmOaDVLVcHRb8Z7sF/Gwy6CKyNfaGSvUD5N4mDhsHr5Hwb8bdlyOKiByedPgxF9/qEc08B7XCviDYuASKIVMsgB1G4ygAdIdRqfQ1NZhssMv43BTmRKPX3rvcFujTrQhLiA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ne2wjoa/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ne2wjoa/"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d91ded8174so3049025ad.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Aug 2026 20:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788232237; x=1788837037; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ENw7urg0+GVpzz2A949PwjF8i3RAVOxo5v//+QnGY0Y=;
        b=Ne2wjoa/fOj43M0lZHYgR77XyqPkE2w41tAdFnEuHFfjWsb+IWwSPX+6/YWbeukCYX
         kcJUAqqz3EMNBkcdxHHcwXWRzN81/KtJW+e1ytpSERzOEWEMaFYMNyjUxDigXm3Xu+Q6
         o2LK+9FOaGRapf6W01Cu5mUjFihV7H49BIB3vE28QSfXdC2AzrXt4ZrKy12Vu7s9ZE0E
         o7s8bhpELs2BbsFWQGlTsS65TkvGyuDaOxa8pDkQv3K4M/3cOJ7QMf1mycTKtuQciw3L
         brA7lo6VvZ1t6Buvt0ZX88S2Hm+fuwfoC44RTrerzwFNQXaaeLEZwzga6SCrF9Cjm+BE
         bbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788232237; x=1788837037;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ENw7urg0+GVpzz2A949PwjF8i3RAVOxo5v//+QnGY0Y=;
        b=C9AoTz8HN3Yhg1Rjaub/cqAnQDEu4fnqRBmz6pmokrNueJ+kVJDz0xFg0R788MXSco
         6w/Q6e8Mh57o6r/r8j23+NY8P5SO40YgdWpVvORy4gXkVjo1unAfR3b23IpfN3oARKSe
         67L7dGCCg5KZhL8tYOlG35inzZ2RBF/AvjDt1MqhBkP9GberNczHU0uwv8bTUo2wm+Se
         vSbrxQX0nX4Wi2xLtcH2oydm7bfrKHrSHf0OwF2xBAZ3YwjZ0rGOO5JR2JY3eBTCDp5A
         HegKXp1ixuyvwOhXWt58Qno0YzZSzqcs6DzyezXQ04XTUwxnf98NOUj6EgCFNNDvooLK
         SjHQ==
X-Forwarded-Encrypted: i=1; AKwUvBww4/ZDihN+B76p6dn1Pq1zLniLqCTgLGmko4yXi9lmmZKpXmlLlGJQ5YkQhTztohJLRUgewaY0tbM1QovNac17C8c=@vger.kernel.org
X-Gm-Message-State: AFuF++lso55E1/6uhB4LmSj4Z22HzMm05kHqd9Lb416Dd5Y9LPWNVvRa
	i3wx+XYUE0VLTKf0SE2hsktv7jXWmxkv7NA87xWv7zOFheY3MNG8CkSM
X-Gm-Gg: AYBFou2FVSVYnOmtRBqxLREIIvLshonNS7yjl48MG9+vALMjUWEI8G1bj4g8T7ec96I
	b0OS5TUQPPb2Vk1nvoTeSwhGyUp1vREmvsidb+TBm6PKVXp53bYARzY5EBzYJZ1mr9k2he+pf1F
	mfSvinQqQSMjFcOQcgjvii1dT3H22eqlNJxMRNEmWdOYWly2KLr4XEHru9Is07WSFPct06v06cH
	fUU8vaP8vYB7WVytVK5G86hj81QtETOMWLdVN+yrVfxiT6R4WCZWI0vUMaWmbJ4O2cR7fWYqaEh
	s2ijHIjzIBI2bfLUDSiow/xMeNPmatShGVWBYHEv1PX3fyZM5FV18j7EkKbv8vRYzm+v45hJen7
	dK/I0AW/c19/O/4nX3s2ibKoa741Kje+u/eboAJe+XhJpN0z1mz7+DeqUOUquuuqwpWQ6q9rcM/
	iKLTzNkbXhLSDzJpsEU6KZlbLL/ts/n/QklbnM2gTZYyXf09C95wAP3hGJpHGEqKQhrY9BItT93
	tEMEZG5LS16O/Tk/DQiclYf1ZsYIA==
X-Received: by 2002:a17:90b:5626:b0:398:9bd1:3216 with SMTP id 98e67ed59e1d1-3989bd135fcmr34928730a91.23.1788232237281;
        Mon, 31 Aug 2026 20:10:37 -0700 (PDT)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:379e:cb2a:beb0:a2e8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d463798sm2813901a91.6.2026.08.31.20.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 20:10:36 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangbo56@xiaomi.com,
	lipengfei28@xiaomi.com
Subject: Re: [RFC PATCH v4 1/3] trace: add lock-free stackmap for stack trace deduplication
Date: Tue,  1 Sep 2026 11:10:06 +0800
Message-Id: <20260901031006.357894-1-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260821235129.078dd489@fedora>
References: <20260616064119.438063-1-lipengfei28@xiaomi.com> <20260616064119.438063-2-lipengfei28@xiaomi.com> <20260714171144.4537f163@gandalf.local.home> <20260715031245.2571869-1-lipengfei28@xiaomi.com> <20260821235129.078dd489@fedora>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pengfei Li <lipengfei28@xiaomi.com>

On Fri, 21 Aug 2026 23:51:29 -0400 Steven Rostedt wrote:
> Honestly, I don't think we need to be as strict on reset as you are
> trying to be. What is the worse thing that happens if a reset happens
> while the buffer is not cleared and the trace still exists?

Nothing that hurts the kernel. The map side stands on its own: the
resetting flag turns away new get_id() callers, synchronize_rcu()
drains the in-flight ones, and reset frees nothing - it only memsets
storage it still owns. So there is no use-after-free and no torn
read to worry about.

What is left is purely what userspace reads back. The buffer can
still hold TRACE_STACK_ID events after the map has been cleared, and
those ids resolve in one of two ways: either stack_map has no entry
for the id, or - once tracing continues and the slot gets reused -
the id now resolves to an unrelated stack. The second one is the
uglier of the two, since it is silent misattribution rather than an
obvious gap. Either way it is misleading output, not corruption.

Since that is the whole exposure, I agree it does not warrant
machinery to close the traceon window. v5 documents reset as
best-effort and leaves it at that.

If you would rather relax it further - drop the -EBUSY when tracing
is on, and stop clearing the ring buffer, leaving reset to only clear
the map - I am happy to do that. I would send it as a follow-up
rather than hold v5 on it, since the id-reuse case above is the only
thing the buffer clear was buying and it is cosmetic.

Thanks,
Pengfei
