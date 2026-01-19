Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5549A368262
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768828609; cv=none; b=n/mgGoSDLmR8F21C6cs8n0b6pQK1gREiSCsh8NUXWb0zXmjdUqT+NzoZWqJTfwb9INZkJJFU9iHEB8+rrIm2iGMT5LbhjyqLWUlhMTLos1ueUyGZWlqFYZWajBiEyO2BqwF57gCRk04nrNLazlfAJps7KrcYlRN7gcN6kk1F5rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768828609; c=relaxed/simple;
	bh=K6XZoyNgA4mHZWohG8tc3L3ulzvqxFpcRY8Ozu63mcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bHu8AymInYsf/XuQOIn7pSJjxeSQoBklOPnnp1GsWv1njqpIIocW8zU5RTvU2jY+Ol0FQTeTlfuQpA01cLMVIR3IDhzRkqlOi0HexdHsBDeY4SgAdTRmgUSC7ko8BOYo2y/scUghLvOxvIRWv6IJv7HCNdoO4LxCEeYFOBEYUss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BUUkjRGS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUUkjRGS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768828607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xdz4rb1d9PRbGxq2hK7H+gxdLsBDCZap6WRSCpXGcXo=;
	b=BUUkjRGSf1YVGfaAeiaU6wWnfFbLp8k4yrYCXxZJdVxaqYG7tfqNNA/BMIGFyo7mmfNXEk
	gBAHwEAozbQOvA7jl/mxJHyzmVJeFVrZYnlENqFeZiXVguwW30eJMzwv3LAFjZ//gzVRy0
	QG1Vkm/8ZUeGM5YuK560g+FDWIGPObw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-lOw3X3-VOECB_VP_k95M3Q-1; Mon, 19 Jan 2026 08:16:46 -0500
X-MC-Unique: lOw3X3-VOECB_VP_k95M3Q-1
X-Mimecast-MFC-AGG-ID: lOw3X3-VOECB_VP_k95M3Q_1768828605
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4325b182e3cso2638746f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 05:16:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768828604; x=1769433404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xdz4rb1d9PRbGxq2hK7H+gxdLsBDCZap6WRSCpXGcXo=;
        b=gELBmCT+EnrQ7mplzU0jxrD6IBcnPQCmEfGoB+52bjApL9TCE3ZD8FtytVygt0F/C1
         St8IbmGIv0CxYCvoslN/pqjmT0I2kjmwH33tAXu02FmvsDkvqD59lr0tgR4rA5XYZhfW
         sSs55e4qPhE5UzAukOYXcUcs/2OiKv3bevrocoOTvD3OXpbOOO3nlkUnfQimPb91Pa6M
         8OqJkQyzlcxY3XtHXGAyLfd6nQdIZt5jo3vWmEOLz0iR4YwWcuBoZyb+zao/Eoj6InXM
         1eiHaBdz/Z7Ht53It/n+muECSj5wvb63Kgy9CuBh4XRKZN0Dhsd0dr/0I0n7XL+vYv7B
         gInQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5b1hbnYm7zxGIJiF2SZewk3lpnP2sZI+5P4F5d3u4E63ceWfUerwuC1VvKQqeLhYoAKLbODTLs7NtYJNpBpFPEaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfJqSrm8RK8YTSBswnNBoy2cvPfxEQruaTI4istwtZ8oe0yJ2G
	qPBlD/+J2UzEUPCkYiHfFp6d6DdprKMo4fnsusir2jtxu0z6e0/sGr0EalFvNCmvIQvRxMHnJag
	shIo0CUEnSKfnJReGEnGmu6uyvd5hA1hmhAeM5tZbVu//+kSN+FMWi1culQ5FgUZQ2CZjsSLTcT
	TK+xJNnQ==
X-Gm-Gg: AY/fxX5AHdlwZYmIBAbCy7EqZ4VWozMyA9cy/fl1Rh9GWCgjn/FoaS4zj470WcrK64p
	yPuECW5YH3dK6CHMc0LNqQPGcBIpJQWrELtbbX1EDIhTEH0i6ZNWWsdAdvbPQV0iYPJDAeNutVk
	zXxyisbHPpZt+0PGXeZFf5eTZa92Sbj9r/7HfWZbPdCfyyY8EHY/luMiB06MP/4qpruHO12JCok
	OsN1My2cBgo9VHuSgBSvKyOyI63LZT9jG7AvDYBfuTGmqROvUK84N8nb8DT12YnNrsK3aYtCJlL
	LvDQEpTRkn0W3Rf0xpvlI0u5KvkyhtixGuRNV50VkDoenEckDm2rxzx3WJv4Sp6nYiprZgtV8HT
	VQXMN8GmgaFiFdpGRCHyf6s9CkkiVuGN6RdiBqKrq
X-Received: by 2002:a05:600c:8a09:20b0:47d:8479:78d5 with SMTP id 5b1f17b1804b1-4801e4a389amr113571835e9.7.1768828604572;
        Mon, 19 Jan 2026 05:16:44 -0800 (PST)
X-Received: by 2002:a05:600c:8a09:20b0:47d:8479:78d5 with SMTP id 5b1f17b1804b1-4801e4a389amr113571385e9.7.1768828604145;
        Mon, 19 Jan 2026 05:16:44 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071besm245614985e9.10.2026.01.19.05.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 05:16:43 -0800 (PST)
Date: Mon, 19 Jan 2026 14:16:41 +0100
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
Subject: Re: [PATCH v4 14/15] rv: Add deadline monitors
Message-ID: <aW4uuSUaG-W0NWuI@jlelli-thinkpadt14gen4.remote.csb>
References: <20260116123911.130300-1-gmonaco@redhat.com>
 <20260116123911.130300-15-gmonaco@redhat.com>
 <aW4PvcDxBJnDLJFq@jlelli-thinkpadt14gen4.remote.csb>
 <5df16facba05b84857ad09cee12df0c19a551285.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5df16facba05b84857ad09cee12df0c19a551285.camel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E3I3_XWACljGhKRKxLCU126C5WILkYI1Xba1YUF_W6M_1768828605
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 19/01/26 12:35, Gabriele Monaco wrote:
> On Mon, 2026-01-19 at 12:04 +0100, Juri Lelli wrote:
> > Why use pi_of() in above cases?
> > 
> > For the first, in case the macro is called while the task is actually
> > boosted, we then might continue to use that even after such task gets
> > deboosted?
> 
> Mmh, yeah thinking about it again it doesn't make much sense considering we are
> not tracking when a task is deboosted, unless that always corresponds to a
> replenish. Thought that doesn't seem the case..
> 
> > For the second, current PI implementation (even if admittedly not ideal)
> > uses donor's static dl_runtime to replenish boosted task runtime, but
> > then accounting is performed again the task dynamic runtime, not the
> > donor's (this all will hopefully change soon with proxy exec..)?
> 
> At this point I should probably just ignore the pi_of() right?
> I'm assuming the original (non-boosted) parameters are more conservative anyway
> so it shouldn't be a problem for the model.

Yeah, it seems alright (at least for now) to use original parameters.

Thanks,
Juri

