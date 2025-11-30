Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B31E21B9FD
	for <linux-trace-kernel@vger.kernel.org>; Sun, 30 Nov 2025 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764525369; cv=none; b=nn4/Nm6/s2YvL4oROiUjeHLwiG+IGEL57SheUhQBFcKeW1rP7ucLUmrVZolRqfqoiBU4VAXT2IRu20Xr1Q3CYU8QuvyEPl0EBr+ACfBiVnmA31Q2+ksa0g3/D+VlZAHuvLgVcgIBKTBjLlffTwoBwcaO8kygzHVcxXRbsQocCRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764525369; c=relaxed/simple;
	bh=27WbreY2RKmBEG/BW9KQXhwy/0tZWPSyiK6pn9laG6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmOOTX91qn1JxXdszC0ynp3kYH3q3/ZESpdlrVbXpzy81jKNWFeGNkePFudMguNegK0ya4hhvGBsD4eqc3nmLCxtIH7XWZYHNNfh1PQhqeTeMORsWZAN2PrV5o/JnSjlJHCvk0ZtZ+uGJjCtmymNHFQBS7wD/6sb6+mNUrp+idw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqNts4w2; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqNts4w2"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-640daf41b19so4243302d50.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 30 Nov 2025 09:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764525366; x=1765130166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wUD/yBt9NZ9+A9XDWEgi0gEwekBnc6bPrryNuMfZMEw=;
        b=jqNts4w2unHzV47JmXIbCJ7rKQzQZ0wAWkLT1kyHY4rCVObgD9iR6kW31XWKz0rrBI
         mTzZAwVKaU3RE11n8WTkbgW4vPRVINIGeQUGqYhD9UQ9DhhO84aDdzpN5P6FYxXFbP6+
         hOk9WmwzGz0zQ2Ac4sf4tqaREcyp8ei6ydBM44CyI4T0ZGHC5p1nRkZE2xF4oDN9YH50
         duDK7rp4o+MWeB7H4X1demIvhShJaXGYPPiAglTXOxQmV61FdxFN445VYmAzTM7OpH+n
         b2/Sgl8EyfB0yQNQz9zZpKxF3A426ZHr8r90P7ZFcCUTUQas1RtJ4ocuGr6+onM3agHo
         t2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764525366; x=1765130166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUD/yBt9NZ9+A9XDWEgi0gEwekBnc6bPrryNuMfZMEw=;
        b=hyvFiO/P5/9Ky2PpMfugqiOcJf9vHnfV7uBzcZeCrXK+cBAH1hXxpusoGHpfde0gS/
         q2Q8Cuxos0w9s3ny359wmMjEDiju+W/xKYv/0uYdb0LXFqvg8INVjnzj2GhMHHbphf6r
         bMnBW1fi1pLGdpfQ7cD5KgQFG+gLc/lR8OvYnWKCMiJP91zjlhACfBmPcb01ytMEev+8
         svUkv0t67nHYEQ4sNPyZDjNee7sfYISZOy+GALU3SuVVyjh3iTOyPqnIbWVR5Jitk717
         6pDl725MZPOeuxWqPWvugeZv/rZHHd1PrXdhMqRqbHkmXD9Q95yjQvPthYrObCMAfS8W
         MZWg==
X-Forwarded-Encrypted: i=1; AJvYcCWD3pp2Q3zCKKQNW55MHsBBJxCJFi8BKoMgMdjsyYmrzfbk3T0iysdsq93+X0g2n1pvlrMvJa9F/okW5lxM7SXDpyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0YBSAHwGeQWNlq2Ccis2iWh2Ran6QKFdrkh++KojOJFMD8ML+
	AAg9wZSIrB4Vqq1pcWQvoguldSpbZIPk1PbwwiWVCP6BZwl3IlZoEJVK
X-Gm-Gg: ASbGnctpi8yHAgX7zmmGr2e8yj2raAfEArAOFDSyctMLOG4tegbgwuuBnD0i3IivnP2
	EAlkipWxqb97RJAp3K1AF/jHl5AzbG18bDS1SgYnCGV6dHKFq8Vg7I4lpV7VoIkVwvQprBuaHa/
	Q4Ajxb3SvUoKBPC3Umekpj4fai+oAaMYJhZUDnkxAP/+16fwhUF+CAO34Wwsl8ChVGbeIGj3SDp
	tJTzjZ3pRJtiPvFTmrzFfO0flHImB1uFMG+MPQ7cBrziyVIXRl9YXoZCEg7yyirik8mjH73eqJy
	nhQq0RHbQjqlR3kZPInYYSscNj0hrBMAB63S5GP5cBuJS2uiFVZJLXrbnh0KR0U+EnpBm2AsEdu
	9nQxfnWZvnjiPifhX7nmJNNMRv4hV/QGSxYTAbxDUbsR+Ko88j3tpAWHCOGD8BzJZLo6YIK1dqJ
	So8QUk89c=
X-Google-Smtp-Source: AGHT+IFazktIfCN3qlxWEck8ZBpdX6Q85L5F/mb8r4CtsaC7PGh9ijpwS9MHVlr3YNeQOBcTLxwxaw==
X-Received: by 2002:a05:690e:1483:b0:640:d1cc:2be7 with SMTP id 956f58d0204a3-642f8e41c16mr30276137d50.30.1764525366495;
        Sun, 30 Nov 2025 09:56:06 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:b42b:4ad9:10af:cabc])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c4692a2sm3805357d50.17.2025.11.30.09.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 09:56:06 -0800 (PST)
Date: Sun, 30 Nov 2025 12:56:05 -0500
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
Message-ID: <aSyFNSqWv_A7JNpI@yury>
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-3-yury.norov@gmail.com>
 <aStWkK6exUj9YEC1@smile.fi.intel.com>
 <aStYs-LDKbJe6zvW@smile.fi.intel.com>
 <aStZKktOEWliXWT1@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aStZKktOEWliXWT1@smile.fi.intel.com>

On Sat, Nov 29, 2025 at 10:35:54PM +0200, Andy Shevchenko wrote:
> On Sat, Nov 29, 2025 at 10:34:02PM +0200, Andy Shevchenko wrote:
> > On Sat, Nov 29, 2025 at 10:24:55PM +0200, Andy Shevchenko wrote:
> > > On Sat, Nov 29, 2025 at 02:53:01PM -0500, Yury Norov (NVIDIA) wrote:
> > > > The macro is related to sysfs, but is defined in kernel.h. Move it to
> > > > the proper header, and unload the generic kernel.h.
> > > 
> > > Tough guy :-)
> > > I hope it builds well in your case.
> > > 
> > > FWIW,
> > > https://lore.kernel.org/lkml/20220603172101.49950-1-andriy.shevchenko@linux.intel.com/
> > > https://lore.kernel.org/lkml/20240212115500.2078463-1-max.kellermann@ionos.com/
> > > https://lore.kernel.org/lkml/20240215093646.3265823-1-max.kellermann@ionos.com/
> > > 
> > > Assuming it builds in allmodconfig, allyesconfig on x86_32/64 and arm/64
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Actually, one thing should be fixed, i.e.
> > Documentation/filesystems/sysfs.rst:123:Note as stated in include/linux/kernel.h "OTHER_WRITABLE? ...
> 
> And just in case, look into
> https://lore.kernel.org/r/20251126214709.2322314-1-andriy.shevchenko@linux.intel.com

Sure. Please find attached.

From 8b08bfd1d4b885bffb67c548d17d98760ca06e76 Mon Sep 17 00:00:00 2001
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Date: Sun, 30 Nov 2025 12:50:11 -0500
Subject: [PATCH] sysfs: Align update documentation

This series moves VERIFY_OCTAL_PERMISSIONS() from linux/kernel.h to
linux/sysfs.h. Update documentation accordingly

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 Documentation/filesystems/sysfs.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/sysfs.rst b/Documentation/filesystems/sysfs.rst
index 2703c04af7d0..ffcef4d6bc8d 100644
--- a/Documentation/filesystems/sysfs.rst
+++ b/Documentation/filesystems/sysfs.rst
@@ -120,7 +120,7 @@ is equivalent to doing::
 	    .store = store_foo,
     };
 
-Note as stated in include/linux/kernel.h "OTHER_WRITABLE?  Generally
+Note as stated in include/linux/sysfs.h "OTHER_WRITABLE?  Generally
 considered a bad idea." so trying to set a sysfs file writable for
 everyone will fail reverting to RO mode for "Others".
 
-- 
2.43.0


