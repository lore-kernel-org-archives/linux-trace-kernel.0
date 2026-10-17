Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821223876BA
	for <linux-trace-kernel@vger.kernel.org>; Sat, 17 Oct 2026 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792253390; cv=none; b=HKb8F+KrSc6/7eHdvofiOqurYhVu49BSk8SncWX9KivHt+0Cy9EU23PcpJKRXSb9NRUlkzHoeB+zSM6V2BO75J+RKMxr6l1P/Zbb70DRyQPshnmWLMQ56tPXwiqkQoQj3qt1PpKHhUrb0BLbkTE2UI1EHYAigZy/m8o8ME4FjCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792253390; c=relaxed/simple;
	bh=tTcHuoJMWoopIonlj/PQ5Xr+4usFlCPYEylDr8x6qXE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=QHCujk44+59BGNjmafr8IBZogtnVJUFJ0Md1Dt2Hqef4GLMPnp0eNT6joToR8rDCuSq1IAfqID+RttMw/xBumULrT2AsHKSMtA3rnHwS8DMaAxAIE7NtgNnhU6tw8hPCSPqbtUdCEfeFeEb5f8ACJSP4BXxwRK3IrL9L47qwhhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MshgmktA; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MshgmktA"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so783872a91.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 17 Oct 2026 09:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792253389; x=1792858189; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tTcHuoJMWoopIonlj/PQ5Xr+4usFlCPYEylDr8x6qXE=;
        b=MshgmktAoLfM462RRv1ND19tzkgxx12vdbc9tF24wLiw0XOsUVOqg+LKIus9fj28f0
         wbO1Dlo0NH/s8jcUGgnuOotjZBWTmeC4KIKMRsprGZmmy25xHgd31dLAVCRVsOAyyuZs
         SPN7NYPOYHLT3ALJkoOFCYdjMLPPkdZ5z3WofbCAX0geANyqpO5/R2wi2GJJXA3MX0NN
         Bkk4VwORnubi4FTUjT78QolyxERk+ZSSx1KQPYUQS9SdiU1MVj+G5Yb1wta6unNnM+Ba
         SHYmW5psFFJ0ooaeHDc086nyNmIstIQ5gB3aMVVlN2T7v25YBIKSGPdxykC3NivVa51I
         j3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792253389; x=1792858189;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tTcHuoJMWoopIonlj/PQ5Xr+4usFlCPYEylDr8x6qXE=;
        b=bz0VpoO4nSPRPfS4APntOpu9xzDMKMI3rMo84asuiyjI3XA8mtwrEovPbiv/KkYxXB
         k8pYBx5caZ0osEfHeIh2RQvIlJEeAHezmzwE/enhMsoOMKT09YW6SRc43r8WIkY3sp63
         MErAk6IhVB+67QuR9dif2bzgeLFQDxToyrtqCi8DQnuKUGuyz0VarLtnYpB/46/EnBQT
         VFSyHpZyfL/weFUpAVcCKeyx1GV8YUtxG026GUPp0Oczs/Av88Yvh/ftzbo3tvhJLO8Q
         SGycFcQ+8PpeuF5U8ZyW3yLXNezWQcSq6KwI6eCGaxMJb8cZtVbpJxHbsIrShX74aM6G
         C8ew==
X-Forwarded-Encrypted: i=1; AKwUvBxSMxKhUzyOTTolD3S2EKsx0rkLGtlaBjnbR8O0VBZdl9YFTpQTeR2KovLJ0nNxGYjmlBTHaJwwlWqMJlLz95OxrhI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZNS9x9mwHBMHpH8Vp2cloOb6D0mPOXgT/5t4jV5brAO45nFmh
	bZQ9jSxdVqopVkzumCsuB9fILYd2BAusvA88xgTqtF1pvdcTJYywjIUk
X-Gm-Gg: AYBFou2kEm8m1xaEgzGwwzUq8UdqJmxEWlN3n/gj/pGgoXZsMvh6Tsq6K+OUThfHDLU
	Jse0qub9tapd4B05jHO36RcvS4TMZt96iESlbVTnRuNR6y63ulhKW9YHCsGz80NqOJZDLkuMm59
	H+TtrcNt4g78QTufjaYoe7GncA+qPHlttz80oFy03168ZxNT3h2kowcD5wRM15zbVvNg7kYElB+
	v+18Eq698g9Hgkfg8KSu+jPk6QzQdzkZXiUnnJp/ywvpsjnRBiUY1QR+T9YTTv5ktUXwolqGCI9
	NYmeCTR27a/cWvgr6REcDEeRZu37BFcVHREmYpTpnKkyXq8rKeTKy0ig8a0hn7s53li2Dkg+Sf+
	c6Vt9tkqFBXAsHxooNj8ladvuUw+KmyC9DokI/bMEsAYIJuExNwNrBU2pqoahCXqCGs7IDL8WSz
	CGgcM/Z/Y8bJPmvsLYIu8rNc8XAJG6XSNLGi1GRJ+k3WdrnZHBTIPFoqz6JfIxFXNE4ZCe7t6Mf
	+mFKprruy7OS/a/IQ+Y5oZXNmz20ZgJAaq829CmkHzCxAY85k5RFi07ym2H9wcCTUXHcm8qVwiB
	ktc=
X-Received: by 2002:a17:90b:2e90:b0:3a8:2c7e:8986 with SMTP id 98e67ed59e1d1-3aceec73203mr2871670a91.17.1792253388700;
        Sat, 17 Oct 2026 09:09:48 -0700 (PDT)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc48f19d9sm8625486a91.11.2026.10.17.09.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 09:09:47 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 Oct 2026 16:09:47 +0000
Message-Id: <DM78SVMBI2XW.2XHVC67VON48A@gmail.com>
Cc: "Nam Cao" <namcao@linutronix.de>, "Wen Yang" <wen.yang@linux.dev>,
 "Tobias Schaffner" <tobias.schaffner@siemens.com>, "Viktor Malik"
 <vmalik@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "John Ogness" <john.ogness@linutronix.de>, "Gabriele Monaco"
 <gmonaco@redhat.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>
In-Reply-To: <87bj8s8ih9.fsf@jogness.linutronix.de>
References: <20261001152042.124445-1-gmonaco@redhat.com> <20261001152042.124445-11-gmonaco@redhat.com> <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com> <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com> <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com> <878q3xtptq.fsf@jogness.linutronix.de> <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com> <87bj8s8ih9.fsf@jogness.linutronix.de>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Oct 17, 2026 at 05:23 PM John Ogness <john.ogness@linutronix.de> wrote:
> That sounds like it could work. As long as there are kprobes in the call
> stack of violations, I am happy.

No need for a kfunc to get that.
bpf_printk() in the reactor is a regular bpf_trace:bpf_trace_printk
event, fired from the prog where the violation is detected.
ftrace triggers and perf can attach to it.

> A delayed kernel record is better than none. Although I really do not
> see why it cannot simply call printk_deferred() directly. It is safe and
> lockless. And it has the advantage of appropriate timestamping when
> compared to any other printk's that may be happening at that time.
>
> If we are already adding kfuncs for panics and violations, why the
> resistance to printks?

printk kfunc wouldn't be limited to rv. Any tracing prog would
be able to write to dmesg with no rate limit and then you, Petr
and others will start yelling that bpf is abusing printk
and dos-ing the rest of the kernel.
Hence let's avoid this can of worms.
