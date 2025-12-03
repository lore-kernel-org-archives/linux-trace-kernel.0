Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B98398FA9
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Dec 2025 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764781948; cv=none; b=Sb7ymxorZpZiIXDSvwayyMMilZbnPVUVPQaxu75YMK/lMA0050yy0kuX1BGv5ze4B75o8BHZ2PGcks0+JcOMvugfh77hugeQFehEwyDiXfU21mJjAsv0o/THU7USFUUMiVrdzTSTrEKpo8wD2pKYafndrjnPqdfp1pizm9M8/Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764781948; c=relaxed/simple;
	bh=MCXpOHHpeG6Bm1ZLgAakALfHlHZc/OxDqj57EFCGIR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KU2MQjY13rvOb+O9ilxEXZsjMgfmUugMkCCKoEjufRi/rvFMf4ojVi8m/PPBkhh7VAqEiN8wZUbn0cMtpNc32WfF2SppzRxssSQyatfNSZE/RaZ1LXkdAxOnytw7g49X/6N/Xnb1gF+HBwMOUowGVhIWVVHdSYPSwQo71faHoAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ai58hPyg; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ai58hPyg"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78a76afeff6so145197b3.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Dec 2025 09:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764781946; x=1765386746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+dMlhUa22KWJ2ilQ42UhqcCRS5uDTPNIwpYqFYW9E1I=;
        b=Ai58hPygDxhbfWKDeh5VKKyscX/dOVaSFbwol9eEEH/wRu3CqB87sdI7QhcMTMS/ak
         64F04bk6we8TqMEh6GbsU9aApXIuzosvs9M0FPtEcrmDF3iNvaEo8t3/j/G91Sy2g2A8
         jpEr7/b2LPqQ9+1V1wufYbpVaeCo965foLgGxZTWbc91dVylt24unI1jlwvX/8Z2QKjh
         YEP8Mt+6GA7wC3dz9+f2kwUcNRrmvxmb2M2POBfrHnk66edkGzjHW4J20HdICquFr5UC
         pfYowchQVfT5BLmb/v/bXy1usbVAkjJiXP/2dugI+KA2a+KO68DSlbJpsob+G3pEDb7S
         qHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764781946; x=1765386746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dMlhUa22KWJ2ilQ42UhqcCRS5uDTPNIwpYqFYW9E1I=;
        b=KDatqn58xQiIfQkhHC9Gdq/OcAaBInzGOGnAjblQIbC6AMesOdvtY6RCLjCY/x7urI
         +dCR+/nwSVmD/Gru+MSNNpsh/2U+UDaASddy09DiRTSg3mwyutPHbznm/0fORXRqYGmD
         rLdKl1qM8SyOwkNkQzXcEM80MGEcFmmi6RwHukxwAdVL4WKTDWzPyfZ6d0ip3+ENCbK0
         RZEBUUWncebSq/8n0kqb7tIE5NhOrAZCgLLcVC8xWsEahIDakkS/dZJHuXIM0c8gVFns
         wys3JQYgpQALMu4PAOqzZNaj+mh0mr/wzTeDgZdT4dmDA5nkj/HM1gRPfSQvokmtvP+V
         RTFw==
X-Forwarded-Encrypted: i=1; AJvYcCXIlQNh3hJegAp7LlLxOau82DU7tmI1Y8rEyz9Ki0p82MbezxEQDCLPVc+HfMMADvDvKaNY/wRJd6m/Ia87XTUvKXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDCEhHyA0nrYLi+g389i4oEzNryRh9gRCgvlo2qgHCbtFxESJR
	aUiFgRfSxqNtscy/GInt+2Wcu9tvx9JsH8DBzeJ1DL9l0AKMf6s53Y+t
X-Gm-Gg: ASbGnctq0JEpb3tdxDg8HevdmjVI7PIWqwtqrMZDevGMLj1/XZi5UsHUCYbJ3yyUSrf
	o8vCEhYsP7XsXq4p4ryvXqL2/WUhow9W3eG3c0JAr4Y7AzxfLQAvodfVOKhg/pQ0HHnIExUUn9m
	1WvMGYO6vC3/XVns2048UV3uINEiP5Nvw8c+4DNrpnBWWD7eJMy0pWvtXheoGk0x+PS7VzhL4ix
	OPdjwTvlnruybTnS3k8MX8TYM14H27Pdj3gbvhk0ZGp3L21Dm2cJjM5IDxUZISMq/xooVSNFpTE
	+9L3jmsJsmvxaA1GnY4VnpjbuWcf50f6WRhpbQXI/blQpNHwF7F4CKblVVbLg8peA2aYJa0crJJ
	TtiQIL7eTd4xGqGaLGhOByGHQ5+Dal04+5WZlZCiYcILFsmYaUL6g4MPq591kDKyNvlDOc4WPam
	D8zAOk5X4=
X-Google-Smtp-Source: AGHT+IEFfaor5TGluCdJ9VR8/Ps+0lVeXujezt2zJVQtO7vKz7xrftaiA2O5j0+xom7Jt8H9sL17Gw==
X-Received: by 2002:a05:690e:11c4:b0:63f:adfa:e5ff with SMTP id 956f58d0204a3-64437038548mr2177966d50.57.1764781944118;
        Wed, 03 Dec 2025 09:12:24 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:3422:8bf9:97bc:b085])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c050348sm7461970d50.1.2025.12.03.09.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 09:12:23 -0800 (PST)
Date: Wed, 3 Dec 2025 12:12:23 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
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
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] tracing: move tracing declarations from kernel.h
 to a dedicated header
Message-ID: <aTBvd6I5D3VAT841@yury>
References: <20251203162329.280182-1-yury.norov@gmail.com>
 <20251203162329.280182-5-yury.norov@gmail.com>
 <20251203121007.407eaf3d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203121007.407eaf3d@gandalf.local.home>

On Wed, Dec 03, 2025 at 12:10:07PM -0500, Steven Rostedt wrote:
> On Wed,  3 Dec 2025 11:23:25 -0500
> "Yury Norov (NVIDIA)" <yury.norov@gmail.com> wrote:
> 
> > diff --git a/include/linux/tracing.h b/include/linux/tracing.h
> > new file mode 100644
> > index 000000000000..1989e6328c59
> > --- /dev/null
> > +++ b/include/linux/tracing.h
> 
> Sorry, and I hope this isn't too much bike shedding, but I'm thinking we
> should call it trace_printk.h. It's mostly about using trace_printk() and
> other similar debugging aspects. Calling it "tracing.h" makes it sound like
> it is part of the generic tracing infrastructure.

I agree. I didn't change the name because it seemingly was a consensus
about it during v1 discussion. Let's wait for more comments. If no
other issues, I can send a quick v3, or you can fix it inplace,
assuming you're moving it yourself.

Thanks,
Yury
