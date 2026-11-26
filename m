Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795723798;
	b=RDJbE4vGhscD9aK6bGlX4UGl+I2hhjNd7IZHNB4Cxi3AMQO6BFmOgHuWWtpQHz/JoejE
	 Sr+U4qLbJSpI/5V4YUZKZ9WYfdQF27Th96y5vQEmbL3uIwEckwX+bWEEs/6x7c/xwRClf
	 hVFTlDcP57k0XzlMddK99ieYjimDrb+5XBHB5yV3743UGExZ9FXb83gu6lXNCsHJTKE9b
	 S5LzLzIAhMbuKe2olCOmioaBvMzaCq6zvmZNEmKRYFVARzh3EtK0R//pYTGXQM9XVPY7t
	 JO+qghvNn0vng8hRL0lw+tGcGHGaWtLGfTox4Upb46DBqGqTa04opN1aJd+FhHvFmLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795723798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=/OrrKD4PbU8J1zBT1VW3T/D/BHUVvLrmnY9knf4JEkk=;
	b=ZszlnOZwX2pnIxYCAnQUUVgRvTNqDI/0Ch2Oeiw+jGuBsZkC+vA0f/5VmesYxlcdvBrz
	 54i8EGt8wVfP9pI+803DmtnG9YghDzrWrGfx+XYb2tDrOdvqtSBTquKwdlqW+QKZyWLB3
	 1c5nUpbtOk89ZHEeiHTKmYwe7hXQAkVbTcaJOsuUy2mORAoqEwDN0BAHSLqqK6KllUDef
	 1nzmBTfOGkFWRs7i6HGImdkgMEJzqJBJiggmVQk6c/HxIQsyMIAGPT5Lp8ub2TSG3vcSD
	 6S/9VB3baWPmv3z922gdJdiux4t17sxN/8iENVc5ZgHzr9ARUupANfy+kNJlogTbAgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dn9pOQUq;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CF3606A68C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 20:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17CF3606A68C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dn9pOQUq
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-490f38e9688so5169144f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 12:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795723796; x=1796328596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/OrrKD4PbU8J1zBT1VW3T/D/BHUVvLrmnY9knf4JEkk=;
        b=dn9pOQUqmIA6QOfUKt+k2aFnxD4sE8qGh9LlHU/8NKYf+C/7yk80j94i2FYny3it54
         bs3ukKO5Kws0wO/QML1kVl2cKdTDNv8mhRLT/ksqWWIvbb/HO8qnU4b0xRRnl1CYWRf3
         FxMAwLQKk4Ki/3rkPq996pKuzlCr8CpwrLAwHz6jk33jzCEv1rlYMOsfIwLGRocp/Kd0
         Zd2TaIF73+Q1EflQ7Y+aiKJixdAupQH8Nv9wa2VGekg1qC9DhbgRntOW2SoSRv4Av1T7
         80yMBniIozPDV53Rh6eBJI0fwIy1E4E6Ri1R980idAbZpw2QN5lHwC6vce7iKQDSzwdt
         tGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795723796; x=1796328596;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/OrrKD4PbU8J1zBT1VW3T/D/BHUVvLrmnY9knf4JEkk=;
        b=cr2qRipphdAYyf5mmokVFHEgNw7v3ajR7y0ISVUicFUdkUqDrdU5DEE0hflnOGhUjV
         pp/DJN4OBcyuI9ps/DTCr26B9yqke1UpwRKn1T3MUo7gm5ulhEy0j7Y4Y2Gy+oy5zaYJ
         bXn0GOUPNXltgXPNhcf6roG9/ck7+9WxZoq77WVRpU9mQL7hOJW4gjPZS42FsLuLrBKo
         l4yjuqnC9rcuF1J+peL8jjsWccvTyd2IxP+vuy9dIa2oUww2XKhzLJCuCY4J9d6PwQ3/
         bs14YaVfu18oOJSy0OgHatMynMYXPyVg1zn1toYBG4Kvhn6Me0c2519BF0vmImFFnssG
         angg==
X-Forwarded-Encrypted: i=1; AL+hErGyvsNC0eQUWaHnYmtc/ue0WmdDg+2M3Yt64gjJXa+lhT2PWA0Ag1jIjiMqMNTLyD+h+pMSjHcNyDsnk968yvm24kQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ilx1RwdIwUBWVh6kL9/JtWiU6kyW3wTLh/J4oIC2f6RTgzfir
	yndZZTDKKqNaGYQFdwlJFyXlAYhXySBkAk18KnCNBiOPlpURfpLhylyEB5JCiFvAupf1xQWlLru
	KN6J0iA==
X-Gm-Gg: AZFdTZe/mtYi7A5K25VEnTDFPJjWRWk6wJFk/bQ0lxUtxQMi2MjZQuC/0sfWRFtXmHL
	sNNme4ySKCsAprELUns3gigwIkV4pDvS3fmGgkklYjCrxKAs6wffOykdbCKhF+tThTsta9XjMA4
	oe5H0ErpZomxPxLmcrVmIQhahrmInIjojuxPoTP0tMsdn7ApCPkk6xyFxZPNOsFtyRgFEQAgFxj
	BzLOif+1062SqOsnCbnJCU+M/GAc5CzMkNgCRjM5NlyO8+C3/FoOhuQdPL3J+eY8dP1joeMxFqp
	7cRy/7lTwDdsWQx9JBCKqHYwA1NVuDMV5ygMDqmd121Obv6kcAHl9YDjUOe7uhJEQb+q3SO8iqG
	/sPkJPw4ZKDDrhmm0YXUn1SDcbQodDB6YupEWFjHlM8nL5O3tY8fJ0da73VtX78o20hKmavJ1Ly
	u3O5n7UA6VkBHab5bpgD6yKaJmkFhxl7Du1rklahppzbKkFw9VB/y2D/WFA2CF9VYY8WN4PSVyq
	MoCBZLclgRu4PJHkwzAd5Eq36GI7Ap4kgtvYQhuJKD7AbsUI3MYL3VYzAfyPRiaz7Zi0ePIM9qZ
	RRoYJJl2EVnsFH0hUB8YZYxJdcJMe4bH1Ac4GZZM0QL/BHxHoJoNHfGpOlHNd1XTqa7UZz1Vf2D
	NYULwn7Z9TdtHF0Ol5Sf63Q==
X-Received: by 2002:a05:6000:29d8:b0:4ab:1d39:92c3 with SMTP id ffacd0b85a97d-4ab1d39937emr31825976f8f.20.1795723796009;
        Thu, 26 Nov 2026 12:09:56 -0800 (PST)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c340df4sm48791551f8f.55.2026.11.26.12.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 12:09:55 -0800 (PST)
Date: Thu, 26 Nov 2026 20:09:52 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 00/21] tracing/remotes: Add printk, dump_on_panic and
 boot parameters
Message-ID: <awiSEPZdfQog3o-k@google.com>
References: <20261124152845.2233401-1-vdonnefort@google.com>
 <20261125160106.01c468e2@gandalf.local.home>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125160106.01c468e2@gandalf.local.home>

On Wed, Nov 25, 2026 at 04:01:06PM -0500, Steven Rostedt wrote:
> On Tue, 24 Nov 2026 15:28:24 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > Vincent Donnefort (21):
> >   tracing/remotes: Gate tracefs files opening on trace remote
> >     registration
> >   tracing/remotes: Release tracefs,eventfs on registration failure
> >   tracing/remotes: Use kstrtobool for boolean tracefs files
> >   tracing/remotes: Initialise pos in trace_start()
> >   tracing/remotes: Annotate remote shared fields with
> >     READ_ONCE/WRITE_ONCE
> >   tracing/remotes: Use a single per-remote polling work
> >   tracing/simple_ring_buffer: Add support for compressed length
> >   tracing/remotes: Add dmesg tracefs file
> >   tracing/remotes: selftests: Add a test for the dmesg tracefs file
> >   tracing/remotes: selftests: Prefix hypervisor folder
> 
> 
> >   ring-buffer: Use irqsave for the reader lock in
> >     ring_buffer_poll_remote
> >   ring-buffer: Avoid reader_lock deadlock during panic
> >   ring-buffer: Use panic-friendly locking in ring_buffer_iter interface
> >   ring-buffer: Add kerneldoc for ring_buffer_poll_remote
> 
> Do the ring-buffer specific changes need to be part of this remote patch series?
> 
> They probably should be separate.
> 
> -- Steve

I could separate

   ring-buffer: Use irqsave for the reader lock in ring_buffer_poll_remote
   ring-buffer: Avoid reader_lock deadlock during panic
   ring-buffer: Add kerneldoc for ring_buffer_poll_remote

They are into this series because those issues came out while working on this
series and I thought they weren't important enough to be on their own, but I can
surely send them separately.

   ring-buffer: Use panic-friendly locking in ring_buffer_iter interface

This one however is only useful with that series.

-- 
Vincent

> 
> 
> >   tracing/remotes: Use ring_buffer_capacity() in trace_remote_has_cpu()
> >   tracing/remotes: Add dump_on_panic tracefs file
> >   tracing/remotes: selftests: Add a test for the dump_on_panic tracefs
> >     file
> >   tracing/remotes: Add poll_ms tracefs file
> >   tracing/remotes: Add trace_remote cmdline options
> >   Documentation: tracing/remotes: Add detailed tracefs layout
> >   Documentation/kernel-parameters: Add trace_remote
> 
