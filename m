Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0937E306764
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270623; cv=none; b=erftkKb+iUxqyN3k3CEjIgQoN6HDIkTtcmwSsW8HfRqdmdJU1q+xkepNXPfrac3MVei7s/eKj7xMumXJft89o07LhwYd1qf40F8It/flvshGLC9GX8+MSLWNyEC4ESzJIrjFpO4sECw8U7hrO6is9MXZ7bEJ40AhxMsofmKkgzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270623; c=relaxed/simple;
	bh=WynuTooh3d2w4bp9yyON0x52RjuGtTuYYXM1KX5OJEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzYRiYRVaeJ0exavkKjsyA8+xXapabJV/5z5zkGW4wShuUCzRmWTjAWoIKAu9Sklky9ZvGW9hz1jeUeaMPR0XWeIMeT0htS0bs1BeWk9KsMbtf+Y7FAMdCq0nHbjsJ2y/ptFeQZ6UwJryOu40A61SxpWDeJPWWHZmli5fVqSOpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gg22Jx5Q; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gg22Jx5Q"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1c26d7e951so822347566b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 06:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788270620; x=1788875420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F8+SZOE2xWNs6AbBanAPIBFLsvkxmbh30lToZDOa/Pk=;
        b=gg22Jx5Qw01lioC0iaWB8DT6B8dQEafNNz5j4qYEcayCJlyo4TAkRZnuItB6qkWeTM
         uO8TmfOeN9gDYbwXvEXgrNiuXsmI9yE/DCm9o2KXxGJ0crj0WmHy/WXdCwaW+iikD2Bd
         P9OVKmecUTFoQ8qwOYniOhCIaNgKGRkBDdfHtt1lFZs9h6GJ+Acf7GfJGp0obAQK/ffP
         22z4KWM551+UG1e/J/bTnzoYulxOhiR3YmwDJrK0KFej9dZ4tmIDctCw0tH6lf0eo/Is
         MYy/qsueTmttzEQOJskT3SB3Jy1jeSZvV7oXAp6iI4htszKNsbtSWFfcrdkOw1s4GZqc
         jvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788270620; x=1788875420;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F8+SZOE2xWNs6AbBanAPIBFLsvkxmbh30lToZDOa/Pk=;
        b=eyqmIOXJLJWq1BQkUa6scqXUXY3VlqGox672NLd/665tNgOqa70k9lqmNve+ChbOOT
         N2GbmuFeNn6c+BCW6ukVAerLv1ojgvVVASVA20iwN7xdkNHylhRVXmVfc0zd95YD8a91
         1xPFR02QwYeds8fsoAtTyToN1QFuFohrsoEhKDkiaaYp70Rq0Ra25JgMTg/hBYzhql7g
         0dgMbxk+i/w+YhmRldp38mqByrcbOhmLX9Cf8cfKzieiEJ/f9V/cY8lv97lkNAtcFYyW
         Hc9e+7EyGzgl515606BzFBS11dCFwWbts6wL6yzWb7W0tYKJXSEtju5tilztrpQ4Rwe9
         97fA==
X-Forwarded-Encrypted: i=1; AKwUvBw8+fsDt2Cmb+INIEgdvBnJDzAMQKG1rOydtxhLXFRNLJV+C2X/dF7vbJIrOKjaLt21Dh1iuBfZB2nad/qTQIOVtPA=@vger.kernel.org
X-Gm-Message-State: AFuF++m5Iozq0gisge3E9rH9xKqTd8RSVFwRAkLrirHPKqoyA2/vdKPs
	tvI9MBjvccc1DaJ9ttSdWq4v0en6FLPaW13xyJRFtSrj6ctYzJRPt7eq10DLVSSpSQ==
X-Gm-Gg: AR+sD10NS9glcH16diAOqIs0RMLlmWSQCzvu+5FdDOLSyVNiAP3ySLDV19n21Mxgib9
	61beFH/o805WfBT585kB6EL8eh1sx7oUQz19bpcHrDDZjxaLRpjy67/HhxY4DtWr1DlCC6HsYiC
	yGjo42OrdsY2SrpugFuL995FjdgAJH5tRWj0Bltud9PLrKv0yQ3uBc/xyXRT0Ezpvmd6Pq0umP2
	z1Q666K5EjCgMjjg40rzcUshXTz5EzKl92R84He6QXHCrDsbYINOPMaXjQRylyO0DT0Sk9tLhYS
	YfuDNMgniIL/Y1SMrmS2Z+XYy0x+rIVQ9H/9JwEIZb/18POC7TkzLoPbVHCQWMbPZppvs+giLC1
	T+rVfBOy14tD0IUpP/pJTG4Luwult/+3FNKU6ymujdvdBPMX9ymNEmN+AkAE/goSW4kcX5R8tL9
	UEbueZvoEno7GmppB1GGR1lWQRormYDfdTtwgQvAJpClvGQLa7dcbIVxTdWQpq9PKwjkFcdLZxy
	xDx7ZfVUkebRbcGcofVQT50mUxIbnkD
X-Received: by 2002:a05:6938:a08e:20b0:c25:62db:772b with SMTP id a640c23a62f3a-c25b3bb8c0emr448253566b.7.1788270619586;
        Tue, 01 Sep 2026 06:50:19 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f1b1443sm588471166b.41.2026.09.01.06.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 06:50:18 -0700 (PDT)
Date: Tue, 1 Sep 2026 14:50:15 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Lee Jones <lee@kernel.org>
Cc: stable@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: STABLE REQ: [PATCH v5 06/10] tracing: Fix subbuf resize races
 with trace_pipe_raw readers
Message-ID: <apbYF8rGD5EKG-oq@google.com>
References: <20260813131152.3589632-1-vdonnefort@google.com>
 <20260813131152.3589632-7-vdonnefort@google.com>
 <20260901123444.GA1350131@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901123444.GA1350131@google.com>

On Tue, Sep 01, 2026 at 01:34:44PM +0100, Lee Jones wrote:
> Dear Stable,
> 
> > Concurrent subbuffer resizes may crash trace_pipe_raw readers or leak
> > uninitialized memory to userspace due to stale size values.
> > 
> > Modify ring_buffer_alloc_read_page() to let it handle the resizing of
> > a previous buffer_data_read_page if necessary and add a new
> > ring_buffer_read_page_size() which enable ring-buffer users to not use
> > the racy ring_buffer_subbuf_size_get(). This makes the spare_size member
> > of ftrace_buffer_info redundant.
> > 
> > Use those functions in trace_pipe_raw readers and handle in both the
> > case where the subbuf order is modified in the middle of the read.
> > 
> > Fixes: bce761d75745 ("ring-buffer: Read and write to ring buffers with custom sub buffer size")
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> Not sure if this is the latest version or not?
> 
> I see review comments, but no v6.  Anyway, no matter, it'll do.
> 
> Could we have this applied to Stable please:
> 
> 8a5f63637890 ("ring-buffer: Fix subbuf resize race with ring buffer readers")
> 
> -- 
> Lee Jones

Steven hasn't taken all the patches from v5, a few of them were not ready yet.

The latest version is v8 [1]... and I am about to send a v9.

[1] https://lore.kernel.org/all/20260826094528.3738023-1-vdonnefort@google.com/ 

-- 
Vincent
