Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37567242D88
	for <linux-trace-kernel@vger.kernel.org>; Sun, 28 Jun 2026 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782646425; cv=pass; b=pmD/VAb4uip/AyR/rg6GVW0UCNVcmhADS+Mw3zSqCsQpLIfacjEdYYglWF4wJHyZt4d+wyT7HZbPEXpFK9ZELBQmJehd2fYPBKcv/aZhDF+8T7De1foE0cXhoYe9JMIBld6fhMOPhefZPeUDDoXgn+ReKGDel4Db77i5d3J3GYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782646425; c=relaxed/simple;
	bh=bgfpN079ZTjkfGSzvnJl3HzKuIyjV75/HikjUo6F6JI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ku2GSMhauJuuwMVxMOQCfWVKTT9SbTWxRen50A8witgL+z/LcU7J5gwCRVGaa//YfB+hWEOnuZ0mkIWBb3EBw1U0Iimsg51UywRSMDzbT/BBtdWEhhy0CVa6+9RzhmCQhkoY+nt9lQP6sAcD281zNj/6CTI0Qw/CPjTa9so/Yyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpKJajIp; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpKJajIp"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso31320695e9.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 28 Jun 2026 04:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782646423; cv=none;
        d=google.com; s=arc-20260327;
        b=sgg29CLQUq5mT/zX62zCUfymyzE+v44SyGSDqA8mH7rNGXylgf5MsyKJ2ZMqarynbC
         jexUnxD4RD5xj59MZJbcW2ARERMU8AGSpLZ888KZScKbJKbFcu+7aLpo9XVMOBUfWhcI
         LEG7265DhBecqDlZfSebpeK6qCP2dl//ckAIV+pdq3ypm55rRxwEy7YeenJEjh2mzy1O
         1/gjUXF7JUgW7PVNcQe3fm/Kk3fwJeYTPqjJ8rBdIYeiPPhrbHtDmVjPWtTjvl7LUetK
         DkSTnkE9D5JYm4xSLiXECHJ5UrantcOISBIU08pZPgoOcRe6bWPXO8P+xVLNC0vrMWor
         2+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=CBSQ7Q9WGiOFkEauFRc+1+ZNzSO1tr4SWnVeYuWVixE=;
        fh=D43x4YQZODQ4JFMSiw5NlnZ+juBV5bN85sgddI1DPbU=;
        b=HbIrw8tQJ3sfeJGoiIzBuKZuFNTIzxO1SmOxSPlSbN3ZKW1+Or9epB8wbAD9uFmlfp
         RqRE4bhN6LxtLyeUWIXtQ6v2hrGoYfKc0CqNwTt2zb1HO1NShv7ylYgcETvbX7uHZu+j
         zcGKtQqyX/nFfM/F3/Sd6/rvqWUbpF5orzULjgp5t+QCnhv/QdSQLSekhvGEJ608pP3P
         i7cPL4HM22LtREDHrqimJjDt0qHeWuMDvNSyC+U7s6GP2GuxoDtT3NkAD/U9GX9frYRd
         VQe5rYJKwX1i/yIfpezYKTTGHKZbMGyftnMZomA6bGk5M9mSRi2XTlSoGLarmd+atO4l
         wHlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782646423; x=1783251223; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CBSQ7Q9WGiOFkEauFRc+1+ZNzSO1tr4SWnVeYuWVixE=;
        b=JpKJajIpQ0FsXQUjKhtdpT3iBJKQSG165IVyQXjfxsUhliJGJNWIPAZTUBpR89tEn6
         H2KbKu0pdQJMavGl9T4mRFD/AnmSdewRUk61h87UCuGx7In2VcJLio1PRkbCtBR/gmJ8
         Jbdbd6rkYcCrmaU0jrWq2dffI6HzdULitCNKmdw71Ro4f+P7KW65jPC6eYhMsg16G9bi
         lEPGfBk6RLrg7yrhNP/+rQTuBXYVbo1kur2+03a1gHnXiOTxPSjF+Z7PUuuhQjpmkHIY
         j7BFIP4K70FYuyYgqCiKysNbGPq2eNwB9tY80qeecK8s+Xvd+6ZZtqDg1MfC6SRgXkQw
         K3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782646423; x=1783251223;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBSQ7Q9WGiOFkEauFRc+1+ZNzSO1tr4SWnVeYuWVixE=;
        b=FaloVMLhHkuU75hvgXUK34u80rSXgQZzKRQ8tucEr3k6M/jdRBwPMS+9jJzTIAxrUU
         pEYJ3C+HLnKwno5aNAO26VzhFAXx0RlU7j//xSmI8CT+MP7iHjB4JM7r0d2FTAuqSKXB
         rYYjZOeFQiKhYQwbi6dJx7K4KumISakjg4pvn0xNnODzztnUEEKEZb03DCUa+KgXi90P
         gbeZWwJHlrXGpfadUJFDkEKCl94BzjehbozXG65MwP44Np7cL5ePIxjoAc2XV5+6k6Rm
         0IsTT5L6/H+kl+8yyfuViwSYZBQfCBEX3pWIsVG4CZW0CudnwgUAd2TCS00yS/6xIB5G
         6VJg==
X-Forwarded-Encrypted: i=1; AHgh+RrfaSAK/tnGayfgn2jAbISkDnj5dTYM4rdp1lXxtXqNJ29gNmY61j3JSa2SbrYOZb3u3LaZLxE0RoICCVgtwTWe7rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNecFSje+dwRyKdF9Q9dQCK2oO7gIF8YQkbQgaL8V7IfZ6e5Ye
	SSxQyQRzhNNR8AmWPAZVxzGPE4XnfAfCJ5pc88IaZc+gs80qSJBGnRj6rCWgFX+iYJLbs/GjHlA
	FiEcefrgjX+wG1PR9pf0l31Te+ULkuYFY5Cp6d4Q=
X-Gm-Gg: AfdE7cmOl0lDMKGAAAcL4mZMKGMJ7EcCtnqGbLbM3pq50dJWOwV7wUh3CSuglmTcFOw
	t6zyyzTnrD1m8pGRp7OHKu4vfqdHgpBONBCtZ36k9DFPYGotraZmnK+zTwh85hBw9CE/YUDdIFT
	MHPG/rKfaL+E2uBDPYLB+ahgRqITWFjtAEp0btGFphCk7cnFZYQyqnCW8ZiYD8eNfcgmhQlydQI
	6HT1W6mBc/2inhMaU9yi4RKcnQVjIFgnShGxbzaXiKvB4NWOPnAPiqk6GB5nQum1giemA==
X-Received: by 2002:a05:6000:3111:b0:45e:f684:7347 with SMTP id
 ffacd0b85a97d-46dbf7d1bc0mr22070830f8f.12.1782646422449; Sun, 28 Jun 2026
 04:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Masashi Honma <masashi.honma@gmail.com>
Date: Sun, 28 Jun 2026 20:33:31 +0900
X-Gm-Features: AVVi8Ceiv0d_3j-P-e81X83o_swUGxL0tFzZtYhSLjCxBgrq_DUpuk-krqAYxbI
Message-ID: <CAFk-A4mcCfNBWLw-rMAnC25k8LV6fF2_jGyhpKciFZv35koy8w@mail.gmail.com>
Subject: xdp: add device context to bpf_xdp_link_attach_failed tracepoint
To: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: leon.hwang@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	kuba@kernel.org, hawk@kernel.org, andrii@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, edumazet@google.com, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

The bpf_xdp_link_attach_failed tracepoint (added in commit bf4ea1d0b2cb
"xdp: Add tracepoint for xdp attaching failure") exposes the netlink
extack message produced when attaching an XDP program via BPF_LINK_CREATE
fails. This is useful because, unlike the netlink attach path, the
bpf_link attach path does not return the extack to userspace -- the caller
only gets an errno (e.g. EINVAL/ERANGE).

We would like to use this in Cilium [1][2]: when attaching the XDP
datapath program fails, surface the kernel's reason (e.g. "single-buffer
XDP requires MTU less than ...") in the agent logs instead of an opaque
errno, so operators don't have to inspect dmesg on the host.

The limitation we hit is that the tracepoint only carries the message
string, so a consumer cannot tell which device a failure belongs to.
This matters for two reasons:

  1. Correlation: with only the message, a consumer cannot reliably
      attribute a failure to a specific attach, particularly if multiple
      XDP attaches happen concurrently.
  2. Scoping: a consumer watching this tracepoint sees XDP attach
      failures system-wide and cannot limit them to the devices it
      manages.

At the call site (bpf_xdp_link_attach() in net/core/dev.c) the net_device
is in scope, so exposing it looks straightforward:

  TRACE_EVENT(bpf_xdp_link_attach_failed,
      TP_PROTO(const char *msg, const struct net_device *dev),
      TP_ARGS(msg, dev),
      TP_STRUCT__entry(
          __string(msg, msg)
          __field(int, ifindex)
      ),
      TP_fast_assign(
          __assign_str(msg);
          __entry->ifindex = dev->ifindex;
      ),
      TP_printk("ifindex=%d errmsg=%s", __entry->ifindex, __get_str(msg))
  );

  - trace_bpf_xdp_link_attach_failed(extack._msg);
  + trace_bpf_xdp_link_attach_failed(extack._msg, dev);

Before sending a formal patch I'd appreciate guidance on a few points:

  - Should the tracepoint take const struct net_device *dev (consistent
    with the other tracepoints in this file, and lets TP_printk show the
    device), or just the ifindex as an int (simpler for raw_tp BPF
    consumers, which otherwise read dev->ifindex via CO-RE)?

  - For raw_tp consumers the argument order is effectively ABI: prepending
    dev would shift the existing msg argument. I've appended dev above to
    keep msg at args[0]. Is preserving the existing argument position the
    right call, or is reordering acceptable given how new and rarely
    consumed this tracepoint is?

  - Is extending the existing tracepoint preferred, or would you rather
    keep it as-is and expose the device context some other way?

This would be my first XDP/BPF tracepoint change, so any direction is
welcome. I'm happy to send a proper patch once the shape is agreed.

Regards,
Masashi Honma

[1] https://github.com/cilium/cilium/issues/40777
[2] https://github.com/cilium/cilium/pull/46546
