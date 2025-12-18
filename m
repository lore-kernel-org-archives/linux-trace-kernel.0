Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E672DC792
	for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Dec 2025 20:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766091143; cv=none; b=pW3FGI0ak4pnzmnzkErcEQqYlurc7oSozg802AjezMb3aqeMgvzdITJ9mGJo1IGyJ9lcwCCBYHxAURScfLSB228Ivi+14of6nwZaDbr3ed8lCoYl01D6Yh1yvVzTMvOntnIK+GIfWQfW7CUMUdqH7DbW8yTCil58Vj0IkU4r+HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766091143; c=relaxed/simple;
	bh=HIp67ZJ66WBgktNEozPsyiGDuZDmfpZNOhvVtRqvuB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCaPZLNh5nJhKJ5yfHoTGrE1HHEx0skIjwDvgTNbHOeFiOsFuqB/N8rhfOdwI4CjwDuKlyf0kOXrlxG4dAsUnaZbNonqEjiEJB5PkZqxZYNRKolkhzhieWmDebTPd/8DxzwUIVRXJmN6ZbIGn1PqtKzJQbihYv2WvdiOYwtly/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDEP9YPN; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDEP9YPN"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-644715aad1aso1299759d50.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Dec 2025 12:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766091140; x=1766695940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hFDV1spVh/axh1lyx/WAElGBcEI9dw5Gpw/DvU/t3OY=;
        b=TDEP9YPNoBaQMK+0Gp8KKfl9IhvxD4iPyVMRJ7rYRMT2GkcCBHhW7gvM6ePxkvev9G
         oIyY5E3gqY9hUtLBvCcNssKllwlvR6Ykv1Hw2aee29roAMxJF5hWqV/u70tzYulLiTEm
         YK+QBdqfsIx7kWAeVpoK9sMMG8WOa2IyQfPdOpJSmgaI57XYwcRnpG9dHERilTd5HJNk
         BgowG+WIjj7z6I499eB/PfoujjiSdiL9KTQxNNCMxN1Aom75PDuaz7dEoBMuA2UtFujw
         X78NtNZa0Dqj3eRaJTudg5Own1vzFQDSXTpM6MUNNwRIKO8XiPyOYPWg4JgWrsJRsDBE
         kVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766091140; x=1766695940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFDV1spVh/axh1lyx/WAElGBcEI9dw5Gpw/DvU/t3OY=;
        b=W3xLyY9UY+fO0ObHD70scjYIj69LisvoDfaUwzFAFgBwfpsBf4UDOu0CM0/XcXhoay
         2gplcKutcgf0RqWZ4u2rzE63AvwspJuu6Munp3HKgS2PDC+lEgv8+ZuuW4PZG9MQREus
         GZhwQWc8LKkijlljLdvFlxYpyjmVeO6F1AMbpgSnpdAo1c8ZYBCiVaap9ragYzAq/2Qp
         nRRbooDMu0E2P1CsMPNTbpeWie60oIi7SyzVbrglKTz+I2oJODe6E78aAXFLvuMYmvgb
         CWzO94KObKJBD9A3jEKMyfRHdmpRo0QXJXbUMCzF1awKrmxFYoxGmzFKcqZFnzqB51Wv
         tNTA==
X-Forwarded-Encrypted: i=1; AJvYcCUOIzIX7NZEudgwbtrJD17196kA4r/2/WeM8X9CJbgiDUBpjz366CQYH1rTdRQb4a7Q27zSptDBcJeDxkzpiVD4b6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI6d8JzdY9gRi7iuBti2CrPgZYg6wjAj34w4YC1/bt0oupn9+Q
	+/9+12FiVtHcFI8Na21QS2a93QYBITiRv0+J//GoTRVWrjgJeB3346Ft
X-Gm-Gg: AY/fxX74BStggW+96TnKmUVz0EqcB3e2jM7cXxnBYYJpnZibYVH4oECbBaZ+jkMNtcr
	a/06cojHEMLXADwQryuuTw71Dogqc090oqsBIkkJBhISe36Ga28yGiOzDuN70/cHONZm2an+X5s
	bxW5lz83Oj2V1OTYZWftBFx3y/2QI75gRYc6MLs0tv29uvslng+WVgy13Rp80rSdRzTzXRPMqBE
	8/Yr8WCzTEHRbPbAg/u1G7K1A11NVa8OR2syL2vJrowRIzBPplYem94pDqykh4YQvMNjhp7Q5T8
	tUq7B7LA5eNNvn05sBRkmRoQblug3no2cN40+s/wSGHbvBtJ9lm5d0zR2NDyuoxNG/lWrr0e0mB
	mD4I1KyreSLaQnWEhSgaC2rWvmq1Imw/QFUh2VDIaESBsnW0tNiIYS4jTi3uJNLVhbO/QqanH5L
	6KPTi/bA==
X-Google-Smtp-Source: AGHT+IFKJgg2mFtYeRpAZPfX2mtS+pdy3ddv+t7myY/XFxqvRRKbskRVQyl2Y5hOxjA0iZJLraQFNQ==
X-Received: by 2002:a05:690e:1248:b0:644:5166:3065 with SMTP id 956f58d0204a3-64669d87d09mr709918d50.21.1766091139724;
        Thu, 18 Dec 2025 12:52:19 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:c44b:debe:992d:e6a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb44f9a42sm1763817b3.29.2025.12.18.12.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 12:52:19 -0800 (PST)
Date: Thu, 18 Dec 2025 15:52:18 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	David Laight <david.laight@runbox.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 4/4] tracing: move tracing declarations from kernel.h
 to a dedicated header
Message-ID: <aURpgm7csvlGzSoS@yury>
References: <20251205175237.242022-1-yury.norov@gmail.com>
 <20251205175237.242022-5-yury.norov@gmail.com>
 <20251216161316.45b3f19ff0ad482018137189@linux-foundation.org>
 <55ceb7bf-0fe9-4edc-81c2-d51366847eec@infradead.org>
 <aUN8Hm377C5A0ILX@yury>
 <20251218123349.35339242@gandalf.local.home>
 <95f0c65b-15ff-45db-9845-579f7adf4c86@infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95f0c65b-15ff-45db-9845-579f7adf4c86@infradead.org>

On Thu, Dec 18, 2025 at 10:34:07AM -0800, Randy Dunlap wrote:
> 
> 
> On 12/18/25 9:33 AM, Steven Rostedt wrote:
> > On Wed, 17 Dec 2025 22:59:33 -0500
> > Yury Norov <yury.norov@gmail.com> wrote:
> > 
> >> I deem to drop trace_printk.h from kernel.h - it is more aligned with
> >> the idea of unloading the header. The original motivation to keep
> >> trace_printk.h in kernel.h was just because a similar printk.h is living
> >> there. But after all, this is a purely debugging header, so no need for
> >> almost every C file to bear debugging stuff.
> > 
> > It is a big deal for debugging stuff. A lot of developers debug their code
> > with trace_printk(), and do the "shotgun approach", where they cut and
> > paste trace_printk()s all over their code in several files. Having to now add:
> > 
> >   #include <linux/trace_printk.h>
> > 
> > whenever a trace_printk() is added is going to be a big PITA and slow down
> > all debugging efforts.
> 
> Eh? Maybe a PITA, but surely not a big one.
> Slow down "all debugging efforts?"
> Please cut down on the hyperbole.

For me, removing trace_prink.h saves 1.5-2% of compile time:

Before:                         
#1 real	5m12.602s               
#2 real	5m11.333s               

After:
#1 real	5m6.190s
#2 real	5m7.151s

I'm building ubuntu-derived localyesconfig with a couple extra drivers.
Steven, if you're not absolutely against, lets drop the trace_printk.h?

Thanks,
Yury
