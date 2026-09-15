Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067D4417BE5
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Sep 2026 16:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488200; cv=none; b=VnQES1JnuLjIut3CoP9iHcr0LMHHHMz5vBPeILMkp6qadTljm8dCm2RLh8Qgl3pK8WGEoyvsHtmNkJQTaDgw/Z1IOo3F615v2lGHHU+FDjcgsIPD5sgqol/clphvFJ0pbU6qH7bxQo5JPFt8hSu0TGcGc+crL13bkifmjtugMhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488200; c=relaxed/simple;
	bh=D3oau+TXcYzBPkd1gtd2LCOxJTWWah49cdKBmX9WcUI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s152Z55ynLbFsOmNYI8LqYFGZ37h16IGX4ROYZyM5OEA5pLb8jjSxVT49yn+Vd7fsyQuwhZtRQaX73OvcJqcrNtQpCjb9+hR+Q8Bk9ML3nSIcJWo4cvunVn2oMkrGmESJShMw7MyER6s2qksqSTXhUOnYWYuwIehs3c43nYvycQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=WrecKWsw; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="WrecKWsw"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910cadeb0so314084485a.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Sep 2026 09:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789488198; x=1790092998; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D3oau+TXcYzBPkd1gtd2LCOxJTWWah49cdKBmX9WcUI=;
        b=WrecKWsw/pL9UnNB+6SpgvBzs9UZDNBSVMQjqpPLcYi8gcMdyuXveFOdkHwAba5atQ
         REzNN9PEs7te92kUawxPx6MgFH5Qjcs39kHIOotY8wWXQlZZb5XYDbk2jMWjK8nF9lGh
         Zzu2hp8DspdOk9OieOqML6YefTI62cHj81GAMw9wFFkm3zroHxpF3MYxqqcnQOXjsmbH
         P4diycGUSjFkv0T8/nzuHY/YkuSUEx9LgfmCPagcu40xv6YBSaGXLIO79ljw4+/T8M9+
         39U8iYQtCIlepHBVjwUE6Kmn/dZfnM2edaX1ePjOtX4QhI2ZWiQ+9Ds9HY5k+GM4ZZVJ
         RnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488198; x=1790092998;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D3oau+TXcYzBPkd1gtd2LCOxJTWWah49cdKBmX9WcUI=;
        b=V7Xf24f7+z9vjlGmzYWYdsV9W7VFAXo7mm7fXdV9ry6qFnAfIaUfcKPkqVF9VV65mP
         liwVBuwSk0WRObgs0wwIBF79nlFEBsDLSdrEQ0NcyHo+rcJcm+YdENOFuqusOg+Y6m99
         KaApeE9lkkrxoXGluQSx/Epb+1H3HO+cAa85BeEiLvGnpaRo+1s3R7LQknFMYFBonyFW
         dJqBB6LAQ6+DwZ1YlKBIpRwGZ7Q4nNFkBbDDeVh/FfSV+Xmg1Gb2qCfYILbumeMiR1TL
         Tf6srPv22tZUpaJudN3BzB8ypbAQNe1wRJQosaR4iKkUja2oJlsG/58G0s+keSAQpX2G
         IvUQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/31SMNr3uVTRGn0atOIJ365iLb4Zh3WQrei5PTwmTEvnuNUZ2YbcP410Nczdhi82/gReeVJY0TKGdWKnoqGuhG1w=@vger.kernel.org
X-Gm-Message-State: AFuF++nRxB+KAu16Sz2tNVGeOvIJyTz4RrivvJjYjYVwPAlmPQ+MkJVl
	Sl7ngFn9WY3gYO4QKCPGWU6NOkCgx896onZUjQ0HfMdd37RwwDaLO8DjcGxn2GAqUjo=
X-Gm-Gg: AYBFou2SGYMYF8l9tEEsgWC2T1mYIm9DkKIHRiVhByw+kk2i0aBom4/ihADSMF/kgwJ
	zNBwez5Z7//3ewBaX/CV+2Zu5RAtPLDrXOdzG5q3UGAdzqE/duWjwtSK9ljEh6jKxVdCh1eG1ve
	hweJBlKDCEk5CitQFUMc4Mas3BR1c6KhO8Pcrobp8SddHxdTn4arOqZcONGf8hJurdfduXU+mDV
	dsHY27dwGONYEzSNJL6R28rxj7gw+blbm9Nsmc3hb8Xwb6ni92jbShlgo936UKv0DLRQohlaaBy
	Ah6xHoQVP5o7wfpXWRcssIi/dMwFYsxB8LRzgKZCaEPd6uYCP7mxk3BgsNoUr/kXT3CzboTKetP
	KSIlyoRG5jpa2kKpmSH/eZfeGPuTg6BmTpoDqjZhB1X8fxg3uXR/a2nnTCjOZIUT6wubOINtQ0F
	AqKtbvlPqBANcLm2xQ/pqvOlBEEVR22fruUYB67+RTfKz3kAB+/obPIuDeJ8qTdY93RgcTw1wDO
	mg3DLOMsWLKEvYPIZtDwOErtweNggkOae+kvWPIW8lJz+9iJTM29Y8s
X-Received: by 2002:a05:620a:90d0:10b0:93a:2d2b:a5ed with SMTP id af79cd13be357-93a2d2bb71dmr992381385a.47.1789488197613;
        Tue, 15 Sep 2026 09:03:17 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939ec337d23sm1222565385a.2.2026.09.15.09.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:03:16 -0700 (PDT)
Date: Tue, 15 Sep 2026 16:03:12 +0000
Message-ID: <da00ebd18989a30a9dfccff23be9ba14.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH RFC v3 05/13] ftrace: Mark modules hosting direct-call trampolines for Tasks RCU
In-Reply-To: <08596bcdd997ab7122dafdb363cf80caaf038378f32ccb89fbca114c2fd9110a@mail.kernel.org>
References: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com> <20260915-b4-rcu-tasks-preempt-qs-v3-5-0ad30c4c5ee7@toxicpanda.com> <08596bcdd997ab7122dafdb363cf80caaf038378f32ccb89fbca114c2fd9110a@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 15 Sep 2026 14:17:49 +0000, bot+bpf-ci@kernel.org wrote:
> This isn't a bug, but could the field and ftrace_direct_mark_module()'s
> body be gated on CONFIG_TASKS_RCU_TRAMPOLINE_READERS instead?

Sure, done for v4, along with the other three from this run: the
rcu_read_unlock_tasks_trace() lockdep ordering in 02, the @regs kerneldoc
in 01, and the Documentation wording in 13 now mentions the
rcu_tasks_trampoline_text() / rcu_tasks_wait_irq_preempted() route the
kprobe optimizer takes. The kerneldoc here no longer points at the sample
header.

The Fixes: suggestion doesn't apply, 03 and 05 are the same series and
nothing selects the option until 13.

Thanks,

Josef
