Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1453C1984
	for <linux-trace-kernel@vger.kernel.org>; Sat, 17 Oct 2026 10:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792233758; cv=none; b=JQ/M+WVB6FxTq7UqwtjKZ78wY2NT9E9Gl82Wd0W8sAmNSRgSByKdSn0OdQHw41p9JAZVxutPSPAg1wkIvlWCBL0tcTpVbCTpfpb0aq1Kx9G8Q2MQ3f95Ywg3umWg6hpZtYcNP9UJB1oxwpLKEUwFj7lXRI6fEv/z3POmYYIXiQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792233758; c=relaxed/simple;
	bh=pJJPWj17cDMLFqShuMdTL0J3HXVL7tLLFruxUwZ7smY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=BmIPdH6CJvlNxLjTpWslcLjIBdAaBfJqcX+4Tob1s0y0L79iD3tJ0ZicMY1gbR3YXsHt5lvSQz/NkospH0x37g35UJAOkV/cNL0vMW/Fchx6Dvt20eUto+w1USesXWD2I5dgmYzGqWhz2GM01znrbxJuQN3nTMIkygu1Z4d4Mt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J75weAM+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J75weAM+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792233755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJJPWj17cDMLFqShuMdTL0J3HXVL7tLLFruxUwZ7smY=;
	b=J75weAM+D199EZkgLXbqwUNEhf0Ljvz3yABuQFERbZeZk046vLSWWlOxgbNrWj/79074oL
	Yx/y5SKI5lu7v4afOpp17DXojRcWh9LMgFOkMEkc2655LYQPicXlwyGJZ2/TGBdx27fleT
	4wUJZd4TGu5U7J7GHfFkVriNqssnEyE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-xT27m2ETMHqqvwrONMUtLg-1; Sat, 17 Oct 2026 10:42:33 +0000
X-MC-Unique: xT27m2ETMHqqvwrONMUtLg-1
X-Mimecast-MFC-AGG-ID: xT27m2ETMHqqvwrONMUtLg_1792233753
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48dfdc0fa95so354289f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 17 Oct 2026 03:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792233753; x=1792838553;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=luoXeTg/DwvulkFlzn/Qv4L0LOqhemmdtqaKBtyvDd8=;
        b=gDPDRqmjigImCpVOFc+STydMxag30JfoU2PIKYSbbQrmuzEo2fMooPhIuElsw4fLHw
         1H3NO40uXiiwlBZHmRvyYg0QzQUGalMwSdgOkXVXgAt8HrhCPqUc5kOO93S4mAH8G40v
         GPDo5oQ8Pti0fP2a3GVlCdH4BMubnTY2C26O9VoTmdeFXq1aK6DUDPB6EAbREBopiqOc
         WIuq0GKflw3g3fdTQNlnXH2BtH7SNeWCypb5Yf5T5hbtWNSOhRxC7/tymQq3aVgNkJBT
         WRl24OMjiFeW3f5FkGKiOSxMKEncSFQUXJv0+cM+urT8K2pTXzpcSwLNaINSjQKPWpBt
         49Fw==
X-Forwarded-Encrypted: i=1; AKwUvByHpzLmdCmZ7SMinM0HSeS6kvEo36VAYStEe/q4h6zBteL6PNRRkyPuWS/r0CSo0NschZlrTlSGWi9Z5J/Y7mfc/XQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVF5sFc3jDgoONEJNsR4IB7EkUWCGdw0FguClnH9Ciw6+XjMmt
	fZdUzxRbLWg9uZLJ5n+WvLHCPxKhhtlQLrVJgO98wnOPJbWOLk4r2nFuKh7CUDnaQKYNqRSdTcN
	w2+PHMaYzxTLeMct0YWwMPaJmVjdmSBD4oC55YeAOKGCjaUfQuyAVkRlqjrsuFmqtIESAvMZwkQ
	==
X-Gm-Gg: AYBFou3mMm5E+kHBeoNmBrZwEhU7TYKv09MEUHGT6e2rv1Lv2HEYM71dwOeXEGeP+M1
	yh6pHXIgcogF5ukrxORhXx4u/x68OF5Bfp1gbgoMUJy08B/kycWvYdkuZJvrBbCvDSP+/JswkYF
	D/gNlxCJG0TrAD1h49ZaTP8vBgBtfn78vLpmd0yN+yMmKOkPYhV4MTjCQR+GZ/ubHhhqmRHbmbO
	K2a0/hinrrOIy77G7+lgKR0Uaz5HbadozwbNAtHziEwV/n5Tz+vn/4/512Blur4XmFrFqrOkfhn
	OSJBGs0RohVKpRwl7oEP2vU+P3QP9LWqS+1yu5m/7XtrE5PGE2D6htItXdxIBxJVg//RpSthN0C
	WjtAb7MoT
X-Received: by 2002:a05:600c:4e11:b0:4a1:acaa:c355 with SMTP id 5b1f17b1804b1-4a1d75f252fmr47251885e9.10.1792233752724;
        Sat, 17 Oct 2026 03:42:32 -0700 (PDT)
X-Received: by 2002:a05:600c:4e11:b0:4a1:acaa:c355 with SMTP id 5b1f17b1804b1-4a1d75f252fmr47251675e9.10.1792233752336;
        Sat, 17 Oct 2026 03:42:32 -0700 (PDT)
Received: from ehlo.thunderbird.net ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd503862sm10597809f8f.46.2026.10.17.03.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 03:42:31 -0700 (PDT)
Date: Sat, 17 Oct 2026 10:42:30 +0000
From: Gabriele Monaco <gmonaco@redhat.com>
To: John Ogness <john.ogness@linutronix.de>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
CC: Nam Cao <namcao@linutronix.de>, Wen Yang <wen.yang@linux.dev>,
 Tobias Schaffner <tobias.schaffner@siemens.com>,
 Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
In-Reply-To: <878q3xtptq.fsf@jogness.linutronix.de>
References: <20261001152042.124445-1-gmonaco@redhat.com> <20261001152042.124445-11-gmonaco@redhat.com> <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com> <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com> <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com> <878q3xtptq.fsf@jogness.linutronix.de>
Message-ID: <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R-QkAzxy2JvtqnShTWiPm3ElYpcnuCHgvskf_AoJif4_1792233753
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Il 16 ottobre 2026 19:20:33 UTC, John Ogness <john.ogness@linutronix.de> ha=
 scritto:
>
>I am still not clear how the rv tool will replace the existing in-kernel
>implementation. Right now violations call printk(), which conveniently
>show up in kernel logs and consoles. More importantly, there are the
>rtapp violation events, which makes it very easy to use ftrace and perf
>features to record traces, take actions, generate statistics, and dump
>backtraces on violations.

The plan is to keep everything you'd now do with perf/ftrace as plain stdou=
t of the RV tool. Right now you can see the same ftrace output using rv mon=
 <monitor> -t for in-kernel monitors (only deterministic automata).

We are missing stack traces (which I'd optionally add only on errors) and p=
erhaps other events (e.g. the -e in either tool if you aren't only interest=
ed in errors/events of the monitor).

Anything else you may want to do passes through reactors (e.g. printk/panic=
 or others). See more later.

>Is it planned to pull all this out of the kernel but then somehow the rv
>tool allows ftrace, perf, and console to continue to work with
>violations? (For example, by somehow defining kprobes for violations and
>writing violation information to /dev/kmsg?) Or is the rv tool supposed
>to provide its own DIY variant of these features?

My plan isn't particularly strict right now. I'm aiming to allow BPF monito=
rs in the user space tool as an exploratory effort.
I don't think you would easily interact with ftrace/perf from those though.

If that's a requirement, you could probably call a kfunc from BPF and attac=
h a kprobe there. I would implement that from a reactor (violations only).

For a pure printk reactor, I drafted an implementation that calls directly =
printk_deferred(), Alexei is suggesting to write to /dev/kmsg from user spa=
ce what BPF passes.
Since you were the one suggesting having a real printk, would your use-case=
 favour either solution? I'd expect some different latency if the log passe=
s from BPF to /dev/kmsg , but I'm not sure that's an issue for you.

Gabriele

