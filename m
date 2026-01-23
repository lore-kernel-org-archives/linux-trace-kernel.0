Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C3E21D5B0
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Jan 2026 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769173501; cv=none; b=MxlnDhTxuv4HaBaa8MIRxlVp27xCKPXddaTL1hkB2nGSKgScDmSOMI600m1r5SQBpzyBfeZ8vb3v1zI/inKuYT6zbQLgxz3MgcbT8WDjfo3GnM4xN/pj5O46DOKhxXH9sopzP6HiluMl9RQzqH6Vh9ZzIIT/55QI+FsmerxYv54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769173501; c=relaxed/simple;
	bh=GrQhLX3qJ4J6w45Jm5Htv0xb4L4VHCgdyRzGiiv5elU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oysN9OCNq1vo7w3x/wMvumMNe+dTT0wruhIaMO7Y9+EnGTUBCWQr7x/tCZvTac7wGaiq5vyxFWDFKgPC+qbCR2mN6jj+ITG/B0+l3xtGx8aQaqV9t5foBiyyX3WjIiArfEO+/HhxSaLpdraZMRWCaDLTCEXBmlVMldj0dWQ8sAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBDiNn2p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBDiNn2p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769173499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bjXPIm7SiNqRIwsRPBl3ikwBN8vOPh/MFbWuMjNL3IQ=;
	b=SBDiNn2pXlZBQb2HCYIrmiOlKr8jI6EuE9BlGYpcXA1LnSTTfef7BPurY8+IR3b2Lcyh5V
	lIEnG8i3ppqkgB/OTcYyX+NJH5LSZCPzFygypJDCHRBBbd1TG/Yf5go3UvU0Tj2uG7KgJc
	moy5epslB952uR8r7R5fB78LtlasVOM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-hTsv4gEKPx-BwvzDn58fAg-1; Fri, 23 Jan 2026 08:04:58 -0500
X-MC-Unique: hTsv4gEKPx-BwvzDn58fAg-1
X-Mimecast-MFC-AGG-ID: hTsv4gEKPx-BwvzDn58fAg_1769173497
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47d5c7a2f54so28652325e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Jan 2026 05:04:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769173497; x=1769778297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjXPIm7SiNqRIwsRPBl3ikwBN8vOPh/MFbWuMjNL3IQ=;
        b=BFZTAsjvmzGys4+uMU98zAjAmJct5AuzKxw/N4CW4OO3b7XN9owN5CXsOCSDn4F2N5
         zy0tY9tn6XcG/sI+k/NNOHikam2jK6B3mWFYp26v6xkRQs3OOPOG1ldlO2PWGMigAKqe
         pyK3ljemu6GGLABbdskTPhyNa2ycrRtFDrynaphp45or0Y8MPOK+TioA9Z3EMkOlmABu
         092tNYOB5R/93ol3gETJor20+sz0Yy8i0I/QOOLTKFsmjD2KjKEJnn1ZdGKtjXXTm4Eh
         wdfgmjDoDNvM0GOg40XH/YK9DLAa6/xAwQQ7gaeTIPeB37FKlpE+cjbuqJ4kIHFPsA8H
         n/ig==
X-Forwarded-Encrypted: i=1; AJvYcCWg1jgM3cr38FsFe/u2FdoJyosdv8FcnSg73lSukHVdNUmOI0/oo8162/IPGw/lmDsr1tJwPxJnHR+9+Gn1N71J2bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMqC+5kTJD4CXY1ozUn0OuFL1Bw3O4cJP06Qh810MihMnBrNgM
	++etLIJ4e8PxWLP3AlS/jucuJlhYch7rWyvsht5ycm8cpAHiTY3Wj8DphdOPOlq1hQfcA868umN
	MFMTRizHaXf/SdXHmB0zP4XyLRechSlx2c07cDbjUd5Yq5EIMQU8x0JUrmyfHK/+vDuLNWjp+/Q
	==
X-Gm-Gg: AZuq6aIosenvvtzJ4pPeJhTVfEYGzw+ymrdhjMZ0PfJziaJEkrsVSeG6NyLw942bLb6
	x8GARp8M+eNvZwY9DyeblG0Nwzsf/QoumfgjJP2vva4Mi6F470zbniebXq87N6qykWtL+5vQAWB
	EipvC35Q0jPhlHP/AFSMWMluRIVy2rsnvJ3yZEDDoYyniafM8CtSN3oKGxyDxV2UqZkiCjhLIfL
	cS9YsdObYCpjz5CITGM/xAhTegNZANhprV5nvk7U+yIphhbf80QWYmBEoOS+/JY34fqMN+XL8tz
	CDBP/AnrLdvqZXINfab2nG7VBIVc+d/4/PmUWJDOA0LFdytbOq6r322Ux7S2QRrx6Fbn6afyIrU
	S7emWosZgHmSUy/5WgaINm3VchNDMAnB6UuwSyIwJ
X-Received: by 2002:a05:600c:3b01:b0:47d:403a:277 with SMTP id 5b1f17b1804b1-4804d2b1b02mr44399255e9.4.1769173496809;
        Fri, 23 Jan 2026 05:04:56 -0800 (PST)
X-Received: by 2002:a05:600c:3b01:b0:47d:403a:277 with SMTP id 5b1f17b1804b1-4804d2b1b02mr44398825e9.4.1769173496416;
        Fri, 23 Jan 2026 05:04:56 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24bedsm6586425f8f.17.2026.01.23.05.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 05:04:55 -0800 (PST)
Date: Fri, 23 Jan 2026 14:04:53 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>, Juri Lelli <jlelli@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v5 15/15] rv: Add dl_server specific monitors
Message-ID: <aXNx9UUpAx2enihK@jlelli-thinkpadt14gen4.remote.csb>
References: <20260122155500.362683-1-gmonaco@redhat.com>
 <20260122155500.362683-16-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260122155500.362683-16-gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aIOXl4WC3b0y19mge3ObmLClNEbNcMQxYM9c0g55dzw_1769173497
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 22/01/26 16:55, Gabriele Monaco wrote:
> Add monitors to validate the behaviour of the deadline server.
> 
> The currently implemented monitors are:
> * boost
>     fair tasks run either independently or boosted
> * laxity
>     deferrable servers wait for zero-laxity and run
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---

And these as well look alright.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri

