Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDAC34EF04
	for <linux-trace-kernel@vger.kernel.org>; Sun, 28 Jun 2026 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782646789; cv=pass; b=JqxgPKz6oZDnqPE1KeXAsKW/tQkezSC4gLlSE3PeZiPaNiDRkoK0fzbHAJqhyS3+lJdITtWdCUDC9gEmmNWOhy8cYweMvx9M37pXWWzhS4YOu6VSBwcPi/z5wCpBNJzs9JZAQTpL8Yii3130hv0gZtj0/P+ajC1ROvLAf/4Rxrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782646789; c=relaxed/simple;
	bh=d498hBMWdU3yNFxeg0vqz25RIl2j1GJoEg3MDJBpWnU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bBy1MU+VZaPl4w4wl2pkT7nDqiAKCO2nGcAbDRZMFHphORkaoy2c60u/sTKGrHVvaGATI8o+NroRG5mLRd4NAT2neln+r6bueDyOL00b0D0BoHs1b9lAD8QUoeUwp4q6F07zN9u+ITRsNbefGhQvZxXT9/mWQAr8OF0MttqRzPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oSTAZ+7B; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSTAZ+7B"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47231f1f8f3so1072296f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 28 Jun 2026 04:39:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782646785; cv=none;
        d=google.com; s=arc-20260327;
        b=R61a1aT5GWdgteoDotLNhYINBVBp/aG5ZyZy5PkWvGMwPD2SALink0BbUSn5CBwF2E
         pRbx946e06YsbhFdMav/ymiM6vabaIqWPbKY65tzxqd7+j5xcbkBw+7ezJleMg8cyP9L
         xF/j1FC1HcjxnbFB/u5pv/bKcJteeAzirhTHZm/LcyEpfDWo1m3Wpf23rCnvmJVZsbq6
         RbmVdWGNoe0+wEaHdYOH2exz5rNT5/LpEjzHaScMtsGyyJYbyCb1tOu/c3dgiZGTO76h
         TiNqya5tGm61JDEtCF+7e7xbtkGY17esSEnKLcb5Soqy3yNs3yVLno94mnhXX/1aKSxS
         kcyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=1k0VeFABvfpPKot2iuI8Yf+iW1BODubQlFUp6DJBWSQ=;
        fh=TdwjGrmf2dQMrQTaMr2rzMiwCwQ3a2Jr7eCL84VxgUk=;
        b=hdTtRkPXBYlMCfTaA/LoDB0sYd3ID3djOcGZN0ZCRpQO7kXTsB6F5u4xxbKP+hSGrS
         VcNmkC3A1mN5UHpXj1UG6QhjLWmyYcqrqauxh21T3jM8T2nRqVNFRBz70idGbBu5AeH4
         9voTzhwun3HnrNsBZEUQ0g4fP3+Lsv1bdj7t9i+OyVUaYilrYxic+J+GNm8EkWn0PuxI
         BboVkiWQ0m71Ga4Vio9jn/V6H0NcjPlwRdU3qvZ7s3Qr7dG9bpt+NfcpjYtNcGaWNANa
         04SrYVVaY979v27apwMWdMzLXXWwSqxPst4lbynqcLDTgqTboh3Y4hvCIV0o7muI8IOv
         jjmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782646785; x=1783251585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1k0VeFABvfpPKot2iuI8Yf+iW1BODubQlFUp6DJBWSQ=;
        b=oSTAZ+7BUFaCqqvsuzotB8ngAQTb+rEB9zl8svMjzjB7b5h7hasER2XV466r4ynW2h
         aujKdUJNkJRAstFCxCptghu4IjH2l8NDqPEgvYnW+aAySXIuqXSRGUYLgMHyY6bOiYbF
         /w/QeRDgzVwUpr7bmoaVPu9yjR0vLM3259X2FTlgdre5aJ2+F4FaKK73xC63oWiafR+G
         W9OsuJh9SQ24W0GxgiJTSzUE5O+6gTImi0qVfS/2bfhgtN/X4zwfDQyTiW1weaiDKL5L
         tQBoYpfUXauZ+RNN+zeiYOnXaJlIiGuYIZ9AZTDXf2NAjj/N8pkwVT87FTxoT32nXMG/
         r+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782646785; x=1783251585;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1k0VeFABvfpPKot2iuI8Yf+iW1BODubQlFUp6DJBWSQ=;
        b=YM19xdFKIfniSpEQjLEQONld64YQdaeKqlveUNdkzg/hH2ICITHXBibNmlPRrhtenl
         CCtnUGDiHvuB4b/y625ud0V3J6DZ0ZlX2wGCGyWCl0a8Iqnxj7oAFzNqLL/5IYq+ohSf
         MHaMlIcJeTDqO8hC0xuiIjKX/bSgwcVo7O8/tTnhHCkiVKyK/BI8N9AyXiUxXh5mfv/d
         +PcVzwKPgtEePB0HYkVZTwi7/8a7sah3i46qXb+QWn5ZWscHJsjCcpeLb+TMkn/pl2+x
         jXB6bYoM33PLr2Hh1nYskKNXUaG5SR1ontK0/S0S/i9mXW8gHGpJDADmU+cMxWbYFKiE
         I+6w==
X-Forwarded-Encrypted: i=1; AHgh+RokdVq67B2CW+wi6y99o2hm32LSyP2DglCr92lTQlLwLvtGe/e418p8saZTQJb2hohAgN0CVQqldUxRsMxLzVWy8vY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUSaRhieG+wn0nEWKzjLW6iqL5oNxFMp8pp8NGSIZjund/wwt0
	XtclQhuxLtDygcoPTHkq8FfIhQ3T1WAevCrpzUiNzWZHY+8cYF5b5qnK/oqdIzJBxN4wob3+WtZ
	w2DEHiBUzGMP1rt3uqBaslgNko5OZ9iMMHOx5hY4=
X-Gm-Gg: AfdE7ckpfssNvzUt9Gm8vHiE9fXJF3gIgbqHb7hecjbRcu1BjN+VPaRL5ALQcXShm9D
	tfr1fCuglzmqCpSrDXppUf1oIfQIq+lmKUnCXxgDVVRHs7dIMST99rBsr6nTRK5jbH18gZWNxto
	uQHW/WgBy8rxOZUqloN+PY5SePHDVeZ3SGll8nfpUSMOzt/IKuPWUpchQz1iyxEHpuFX/vWigoB
	1uGutsT/6PPrzERg3RvmEWxJ4PP88hpDP4YduCsI1YKmVq1go+Gy9+flkNRWauKuyPqFQ==
X-Received: by 2002:a05:6000:40cf:b0:46d:1433:77ec with SMTP id
 ffacd0b85a97d-46dbf021840mr22541235f8f.2.1782646785414; Sun, 28 Jun 2026
 04:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Masashi Honma <masashi.honma@gmail.com>
Date: Sun, 28 Jun 2026 20:39:34 +0900
X-Gm-Features: AVVi8CfDJaopmWM8eZVww041Hj-U2h62NQOVb61mCb6UmG7XUvpGHldL02uI0LM
Message-ID: <CAFk-A4mE9Jweo2hfX7y_85xbPyt0FqpMT1EvqX1OcYZ=LTLgRA@mail.gmail.com>
Subject: [RFC] xdp: add device context to bpf_xdp_link_attach_failed tracepoint
To: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: leon.hwang@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	kuba@kernel.org, hawk@kernel.org, andrii@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, edumazet@google.com, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, I am re-posting this mail because I forget to add [RFC].

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
