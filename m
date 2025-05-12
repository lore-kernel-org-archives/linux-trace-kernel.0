Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B608255F48
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 May 2025 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747036537; cv=none; b=rdS3mCkSsHf/NovYEKVP0WMQ8P+F7wGxte+EAo4PJYpih/11+zwUonyoxufoLNudVWlAXYz4AHXPYUW1ZNOLOdl19uByCjdnSKiAj5SeQ1gVhAe70uFm5GNEA9XUfp51O4mN4hP5uy55AE/oLDehSAyHuLq6+y7E/RoM9wVqHow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747036537; c=relaxed/simple;
	bh=7GONjaD7jFf6DraAUB8mWndfQEMMogoPdAMOxswMWYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=me83gvN6c4YbOAxjOkasCh6Z6mrgl7Q9jfSqdIP4p3DjSTgLtHihMVy9gWIPofaDAKZZfzKi6pfyQxQCBwTRErNQS6BToRZ1d59xHKyOy/kOx2iR9W/xOJYKt4v7XEkYG31GoqFYIOGDUybt+W8nFkYv8aVs1AHWVDKahrSACsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eaUrtNBt; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eaUrtNBt"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a1d8c0966fso2401599f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 May 2025 00:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747036534; x=1747641334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JVmeoRs8wht6ScX85zDxCRxMqcg4xq84fv5EF0eHPpo=;
        b=eaUrtNBtAlkGznj3QUjgs82ayC9haBffhtS0lQhAfxWuDrzuOSOsqgDup6eTvmKNsf
         pKE1L9++VvCAl7SjAaZaxPSZBJh7l9KvDdhGxm8fMcm4IVE58oXAExMfDYJeLxiTfpOv
         PoaZB7g2KpAEy7+6xyFaGstD6+3QOnBTDJ7uCqZi27Yz5UnmLtWW8E9SfrXEyMrS8KVz
         Eu3x/nqzzYMeI/0237a3pKIJHxeTrZyguff67cu3O3OmzT0GjxePTB8E5o1jb1teyi8L
         h7bC+je84/PxyJQC2xbi5ZiJBc/qHXj66Nc9s4QcpR9iyJ8e8QIVaRaj3fApKn2cKEU2
         v/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747036534; x=1747641334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVmeoRs8wht6ScX85zDxCRxMqcg4xq84fv5EF0eHPpo=;
        b=H9Zpadv0ehJ84WO3s7hGxxaX4bayW0WVYiZNZPDIn6akYCgxvJ6oTybH6/d9D02Tui
         Qn9V0KeQHCp5YRHdI+LSgEvAMIaCrefJnQWfmUJnQMeL6EZYqrKLpvCXZuFUUaqo9Z6s
         rQx0Bo0upNKXMAcLcGVwZuThX3X+AD06FwJFGJsdVHVzP7fZlbOQg9O40dYP+E6ax4SM
         fI31itwJhSZWMMTKDV7nzkFKj7dBErPI3sDcytUzrNIqVgzPE5JThQo9pGKBl/naEmwO
         HbJ1r487jsAnaDdmKTnYE/908NbCyBNxIauIY6US8tjA87nQrA/HCFGZRrdb4wVvfs97
         SKGA==
X-Forwarded-Encrypted: i=1; AJvYcCXVy0SlChqAdP0n5KUp2r/k4HHcN0J998HAGXw7KkUpHsBQbyYWbdBHcrMQrmnJJW4rw9Vl/3QTYW/wKQcOWyR5duM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRIouPmSoFOCXQU9X/IhJzZlbpdCUgNekYzh5EyPg+lQmRnPaw
	uR+646VltPxiiMAlcZyT69GcWyWJ24UmBHq2S/y6G/1UsuH88PZj/YHqfzruZQ==
X-Gm-Gg: ASbGnct+pdFOM/ji/aynjOc1c+FvgvizKnX+TZ5uVI6IN/2E+DRSmgLLREsc/aPtn94
	GgPQ/CaeSXwNxaa3M1mW/0ClOYYfR8SUbUg+aONoJcSiZK6gNsM4PwcEigs63t81482lcEdR9oO
	mIu8arBMeLnUQDLSlvQcEw9IMGrGFoLkDQ/B+18zSiSs9BB+lZ+NOkHFmUaub0l4wMlvJ+JjBxg
	u1QNVePR2Im9jb5Y3dqtUJ7NDH/1a1ZjL6z7v6ageUk/jBpM9S+c2dQrNHhkSnCwysf4mrsXkUt
	dF33YNP83cBBfa3MMxyX2hUdJ32BzVfgVBzdcHcRW6tOUvTJofCWPrjxPNMwQ3VKKvi/ohOpbJL
	4EXMmXJdG3brhsioIt4ytWBw91sY=
X-Google-Smtp-Source: AGHT+IHRngy7dyfSblPZg3kx1M0V69ixjtLKeGbM3AJ71FSYb+70+rHci10V2fws5C9DeqNnhr+dvQ==
X-Received: by 2002:adf:e612:0:b0:3a1:f724:eb15 with SMTP id ffacd0b85a97d-3a1f724eb66mr7737749f8f.2.1747036534388;
        Mon, 12 May 2025 00:55:34 -0700 (PDT)
Received: from google.com (218.131.22.34.bc.googleusercontent.com. [34.22.131.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2f65sm11745987f8f.55.2025.05.12.00.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 00:55:34 -0700 (PDT)
Date: Mon, 12 May 2025 08:55:30 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/24] tracing: Add events to trace remotes
Message-ID: <aCGpchGnvyFpWk2y@google.com>
References: <20250506164820.515876-1-vdonnefort@google.com>
 <20250506164820.515876-6-vdonnefort@google.com>
 <20250509154735.530d4a37@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509154735.530d4a37@gandalf.local.home>

On Fri, May 09, 2025 at 03:47:35PM -0400, Steven Rostedt wrote:
> On Tue,  6 May 2025 17:48:01 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > diff --git a/include/linux/trace_remote_event.h b/include/linux/trace_remote_event.h
> > new file mode 100644
> > index 000000000000..621c5dff0664
> > --- /dev/null
> > +++ b/include/linux/trace_remote_event.h
> > @@ -0,0 +1,23 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef _LINUX_TRACE_REMOTE_EVENTS_H
> > +#define _LINUX_TRACE_REMOTE_EVENTS_H
> > +
> > +struct trace_remote;
> > +struct trace_event_fields;
> > +
> > +struct remote_event_hdr {
> > +	unsigned short	id;
> > +};
> > +
> > +#define REMOTE_EVENT_NAME_MAX 29
> 
> 29 is a particularly strange number. It's not even divisible by
> sizeof(short). This will leave a hole in the remote_event structure.
> 
> Should it be "30" to plug up that one byte space between name and "id"?

Ha yes 30 is what it should be!

> 
> -- Steve
> 
> > +struct remote_event {
> > +	char				name[REMOTE_EVENT_NAME_MAX];
> > +	unsigned short			id;
> > +	bool				enabled;
> > +	struct trace_remote		*remote;
> > +	struct trace_event_fields	*fields;
> > +	char				*print_fmt;
> > +	void				(*print)(void *evt, struct trace_seq *seq);
> > +};
