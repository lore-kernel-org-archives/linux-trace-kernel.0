Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C1A221DAC
	for <linux-trace-kernel@vger.kernel.org>; Sun, 30 Nov 2025 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764527268; cv=none; b=NOC3e9h4Bo6yBsQi/jPztRxQdtqUNqjD2cgwXvHTdygwTxif1WFslUEc707CdvRJHm/r/1nm1x6cSC+Rnhq1WyX2smaYwOPto52NQjNtHcaP+PF5mOVBx08oeMtnheAOX5mYMNDTPrUmsPoSb7pFGmF/JZxsvA5WBzKTEwo3CgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764527268; c=relaxed/simple;
	bh=jKo9YN5Ow3alHkdznaL+oI7OWz6x1PeXbTSgFh2nelk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvK64YcGb8nTlODRmZa2Zv1I3g+L9ihb3o2x2zwcn9++kEzrmJ7Tzp7h1fWZg5tlqiJDekQd1dy5pC9Gx6dzMg9E9RRnaVxxpuBojYC+LQ5GnyOIJXg9G3pd2bgNTYB3aqLMP5VPd41pF23pn9C5hsQXS6Z6RUs9ysz+YjuXcFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Im7wLo2F; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Im7wLo2F"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64308342458so2894096d50.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 30 Nov 2025 10:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764527266; x=1765132066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gQ0UOimIv+Gqhv0/1FQc2e2rNrHodQEz9DgOtiLMoSM=;
        b=Im7wLo2FZbDWvS57VeZXCNKGBWg86nCdPDi/2/GeVpjeefW4iNjd9zObOS5o6ecsE4
         g3VQYRGCDfYBkc3SMM2dsQgdeHDGljmIW0e0PlAJTs3fss+h6+DJFdSdEeRArMGvmspr
         9ag76j3uB+r6vAmH0Nf3iOc4dw1rNw8SEQO1B//vrtRIshYnX51aYTmY/qHY2cXFsVTC
         EHFhp0RtjNU3TOZpR7KeVepVUOhhdl8atkjav0RmQKYytJMABfsY91HP6pRwR6FUsNjj
         O1TGmyyfVkeUUA+nZgMntSHG9PXqJ3k0KN60JBxm7cXkYZzwxwMUiv/HfQ+zYqK6X4C/
         uTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764527266; x=1765132066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQ0UOimIv+Gqhv0/1FQc2e2rNrHodQEz9DgOtiLMoSM=;
        b=Zn5L2Jog1N+CYEwGMCCTBI2+f50ktGiZx8NOrFzKwcao6wX8VFuVeiL5TUw2Rshy4l
         Xtou3Lxzvz7mHZ4weaI+WeGbMx7+Ml9NC4wy1uKTqIvyEPA7E9xniWX9B03lJPJVR/ZL
         I2YgFZFiB87NZMrdzycxjW0/SscPMZgKcGxbltNCXrys7iYpshI6knpQlLEUn0Hq8JkD
         gmrYBPkjFEbrnMQH/pG7fz/SUxBcKtJ3q74DdGsY8PBz/632jT0+RFmXTlon6OlATHll
         K5DCF27LuNMNyQXspc4UGBpYLPuD9ZugGm7jXG1PcIEQ7hof46MT2K7Ju2ZCqk+RH9cP
         wEDA==
X-Forwarded-Encrypted: i=1; AJvYcCUSRhZfImefrNGZNw1aAr1wRatw51tGEiY933VWBOEqlf/X3tLUpaGs5hNO4zH1u5BIsyrvdlRUUijjJ9lmxVBy4WA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvLpsMkVHGd1nnOHnW85oBBSsVlluX5yfsd2hIrlGxTFsFGA5u
	MJrA/Qe+qKGTJkhqv3x2rbXkPd3UzeO7KkxXXzl51pu1SmePnTifRcD6
X-Gm-Gg: ASbGncsLNu1muQjc7Q+OA8m0hudA+ChkHzGnCPHJaLz4WllJWbmHzV20RrM7ntZBn9f
	xvblwDOqcwRLbVa1OqwRyx9LW3O0bsWZL/akb4NqQpUD+aW02D6JPEVj/imQDf2AmGBJdN8nwU1
	pYU3ncYAbQe84rgAciJ2Ol4un8ZQGy/bC6xNKcIpEFMApmvFeOLZJMzsAREKfmWfo8OGqwEzs8b
	ud7TTUu/NjsiIEG0Ia093zfiIRp1MPe1lbfeSz8UnmySSr0oRJxLglQ72cEladjeTqSU2kM7EHQ
	Wej3739a3yuIsRhDwMWv+32cVckdSBz6i1A5kWJ30U6buWOuqSzGK6ZdzJGdRd6JgWxk0ipL6V9
	fWbszdf3nFyWkDCrwwhTtIKmcrpWvYDw3sm0jjlwJys0K8pSND8zkM4h/BOyf8YmT3/p9YTCnH4
	r8hGE8M/Y=
X-Google-Smtp-Source: AGHT+IFDyYOeUhT8Bbb9GCbxFDItrQuSs7u5k0phj03PaXnRWntIOvKeCN52kZaBXAUM/+2zDMUHvw==
X-Received: by 2002:a53:b2f5:0:b0:63e:1ca0:be73 with SMTP id 956f58d0204a3-64302ac3594mr20527544d50.37.1764527265793;
        Sun, 30 Nov 2025 10:27:45 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:b42b:4ad9:10af:cabc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad1011c00sm39418837b3.33.2025.11.30.10.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 10:27:45 -0800 (PST)
Date: Sun, 30 Nov 2025 13:27:45 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] kernel.h: move VERIFY_OCTAL_PERMISSIONS() to sysfs.h
Message-ID: <aSyMobJnY4qKmsdk@yury>
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-3-yury.norov@gmail.com>
 <aStWkK6exUj9YEC1@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aStWkK6exUj9YEC1@smile.fi.intel.com>

On Sat, Nov 29, 2025 at 10:24:48PM +0200, Andy Shevchenko wrote:
> On Sat, Nov 29, 2025 at 02:53:01PM -0500, Yury Norov (NVIDIA) wrote:
> > The macro is related to sysfs, but is defined in kernel.h. Move it to
> > the proper header, and unload the generic kernel.h.
> 
> Tough guy :-)
> I hope it builds well in your case.
> 
> FWIW,
> https://lore.kernel.org/lkml/20220603172101.49950-1-andriy.shevchenko@linux.intel.com/
> https://lore.kernel.org/lkml/20240212115500.2078463-1-max.kellermann@ionos.com/
> https://lore.kernel.org/lkml/20240215093646.3265823-1-max.kellermann@ionos.com/

Oh, OK. Surely I didn't want to undercut your or Max's work. Do you
know why it wasn't merged in 2022 and 2024?
 
> Assuming it builds in allmodconfig, allyesconfig on x86_32/64 and arm/64
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

It seemingly builds well. Thanks for review.
