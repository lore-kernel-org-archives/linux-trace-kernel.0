Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C947311735
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wTJpXToq"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d87df95ddso53090785e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jan 2024 01:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704967064; x=1705571864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rg4wmvX3JEOaUNaxPXlZ7EWQ7WRH8BzbgnD+DbwJ0F4=;
        b=wTJpXToqIk/NfMbqCeC9MkhPDYBPWG3JVNkOxnbMGT/7eDvni9Vo1m1gGEtnGqOmWM
         jcD5QIdtHknMHLW9OjlD07Qmy0sUOQ7PU/4jV7/w9HsDMrQ4Bqv/Qfoa6vSA+/GOwQ+v
         Xb4F2m5DWV/OMnQVoioLzfldab6TvMRoCHfgYyckwcu1dTg0tpj7OW1GcIw3wcjqS8NH
         8hzv1kfT+Yvu8Py/J7G9FHide9zm8htbSQB28rgHnVVk0PLYI0utX1XtJW/ef8dmHQ4L
         oJgWm0ULp1whpVhuk0bge0igvtvMasVYYRoPwX1oTH5KorkMgKRVJpH6O4nnenTcZy1C
         GEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704967064; x=1705571864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rg4wmvX3JEOaUNaxPXlZ7EWQ7WRH8BzbgnD+DbwJ0F4=;
        b=mIRjP+LRhgjgz4trjBKvzd2YzOA2n9v4ENNnJ8dlRIWSApZm5N1fDATCQydBO1B59N
         xzWRGt5y3lvSjfIwQW5N5lMWRqDbgGQaNF9dp+3FAlPWo4A7zTcZ+H/tTHM4Zst/VtxK
         Adovdwlc1amjuzyYBfHH/whU/sqnT4TGwghb4wb3WI9Sd6fkDsg6SeWNmQ31zU6fEZpZ
         Q/UYVSmyLWs0RnuKin1kbLXGnLxRqYBjQ/S85lUNkP26JVRukG1bLo7z/GsZ/Lmh5KDp
         E2k6FTb9QLv6208y0gEvLNF3cQVV8/FVIj6/mhy311ErDGB6w7vxw70Y4FRo0WoBVBVC
         uqAg==
X-Gm-Message-State: AOJu0YyloZsg1Z5fQ6rExRYoeCl6S0VQU5GHuI5nn4lmIYOUiEY9f1+C
	jixi7bxOhDM43ZFHCiLvqTBgvPQw5ygz
X-Google-Smtp-Source: AGHT+IFWQ7HjjFwL9jphsXkUr1ha9C23n3m/RGsKF2r+L/5P4ke4UxRNrHgL59yiDHchMve6GiWrwA==
X-Received: by 2002:a05:600c:4f0d:b0:40e:5967:742a with SMTP id l13-20020a05600c4f0d00b0040e5967742amr122111wmq.299.1704967063883;
        Thu, 11 Jan 2024 01:57:43 -0800 (PST)
Received: from google.com (185.83.140.34.bc.googleusercontent.com. [34.140.83.185])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c510800b0040e624995f1sm44258wms.8.2024.01.11.01.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 01:57:43 -0800 (PST)
Date: Thu, 11 Jan 2024 09:57:40 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com
Subject: Re: [PATCH v10 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZZ-7lAdAUxlwoY0z@google.com>
References: <20240105094729.2363579-1-vdonnefort@google.com>
 <20240105094729.2363579-2-vdonnefort@google.com>
 <20240109234230.e99da87104d58fee59ad75c6@kernel.org>
 <ZZ1ir0edlY3OzjyC@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ1ir0edlY3OzjyC@google.com>

[...]

> > > +	 */
> > > +	smp_wmb();
> > > +	WRITE_ONCE(cpu_buffer->mapped, 1);
> > > +
> > > +	/* Init meta_page values unless the writer did it already */
> > > +	cmpxchg(&cpu_buffer->meta_page->entries, 0,
> > > +		local_read(&cpu_buffer->entries));
> > > +	cmpxchg(&cpu_buffer->meta_page->overrun, 0,
> > > +		local_read(&cpu_buffer->overrun));
> > > +	cmpxchg(&cpu_buffer->meta_page->subbufs_touched, 0,
> > > +		local_read(&cpu_buffer->pages_touched));
> > > +	cmpxchg(&cpu_buffer->meta_page->subbufs_lost, 0,
> > > +		local_read(&cpu_buffer->pages_lost));
> > 
> > Instead of using these cmpxchg, can we move this initialization before
> > smp_wmb()? Thus we can avoid conflict with rb_update_meta_page()
> 
> Good point, Not sure why I made this more complicated than it should be.

Ha, I know, that was before v6, where the writer was updating all of that. From
v6 the update has been moved to the irq_rb_work.

> 
> > 
> > Thank you,
> >
> 
> [...]
