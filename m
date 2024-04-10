Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD1A1836C5
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Apr 2024 21:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712783408; cv=none; b=craVyaBbP4wXAqqqE2JYH1YH2OBgG8TMG8LbXL0mjg46d/vrv7KkIJzrZQwiOTjzO6FX9CteIpHSzEZaY966pKR0zBT1z0qFeGAbdgne4et5PLT8uH2iyDAKaX6GzuK7lQ1ijN0VKaQL/yFsesg8WX9niX7hyc30cETd0Gg709k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712783408; c=relaxed/simple;
	bh=bFyrIcuDs7nmErevy2zekDsqStQqLe+bXtd72c5CLDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBZoCHx9MaPuVa16jXYOc3d09oZdmL6ks0vUAYlD+UOZIoekWmA41CAUqT5Nrc8sbPb3SKaK+rjexS/Y0INJz4vKLXz9ooJBA+vMyV6K68wMb4qu22D686LXRy/DOPqRMx2T2NixI7kyrrQiIy0Mhtm3Rvk3YK39KSLMJs5GHb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WNqDt/ie; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WNqDt/ie"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e782e955adso6711022b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712783406; x=1713388206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bv/V2BDcZ6BXQvfxxNM1w/X7hHGQqyp9bJFqKpeVUk0=;
        b=WNqDt/ieiDDCpUgP6O6kSxj5PVgwLbF1THE0dpO5cAhGSYnAcLyFM2h2ZYM73cjp0m
         sW3KlsnS0pwbtBZhVVv73zk25Y0cma1sfOSxSDXZjW8xp6gh7uWH5Rxow3wQRZ9dbNJB
         Fy8vnzyzSN7dwz3UMG4hcZ58Xd3P38YsKWKC1A7f18tnPQWS2WZqmzT56wN06oAvqma9
         cTzcZwExSvVWPPlfX3xOIffdLSDk2ARnk0fJh0vpd2W5nfwp+JZ1QQXiNvKmqMyBS/+P
         GiYzSObqpgC9DuLrrjKCk99Ryh62B9+9aXtkm9cFQHqIAt3AlvBVzT4S12QiE4IRp5aA
         SFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712783406; x=1713388206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bv/V2BDcZ6BXQvfxxNM1w/X7hHGQqyp9bJFqKpeVUk0=;
        b=bpzsyhSnGukW8abMBXTRvSS5ARUuxx8kYFROK8g8kGXYnUCHzMK0ZGJ5qMCjhKl8tf
         gmkt+Z5bpjA0RrHZxXoCzWSvtWfhRFLIJYhoqsBYSkzRvy7/OS/I8Ek7kHyXOed+NAou
         aUiSkyxC1LTTFL9MOdYKDC+A60OLY+1/QFJKsp2a6SJPxkP1aYVX1O0ixtWmJZNYoSda
         HrAD52dqznQ2LP6OYZqqaEaSrMF/r3IJZGpvFpqqsYxk+ns6qDzmAq+vZGTzp7mUO5h1
         +rxPtgNaXwce/H/1gFvur7dOWUqxTql6zklHoOEpIrXE7//iigBiJg9t2GDvPm/7KrMs
         C2YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUatw1hhldOW6uC1OF4wYoCdiqsWTNN70I2vsoTXZSOMXJJBYv+Fa1btrfZvVqX2kbOwu4Q9vefgcHLMvJ9j0cAoGK2eCxq4Zu2vSCoMdvwK2jX
X-Gm-Message-State: AOJu0Yx98hy36eqHo2RL848jjJiqBifcla2+L6RjlE/XyPOL9pMQDNfh
	gH75tz0wlQZoyQNBToDAaBo/wqGtpprteGwgW5GOyxSOm9yOwpJvPeEaxQe/Kg==
X-Google-Smtp-Source: AGHT+IFcUUpsX3kBlOD2hO0EgX46DmOztzcA2srIGWOFuvp0m6/PaSUmCl09aWhXL/OfU4fhOLSkSg==
X-Received: by 2002:a05:6a00:3d42:b0:6ed:21bc:ed8c with SMTP id lp2-20020a056a003d4200b006ed21bced8cmr4678360pfb.18.1712783405518;
        Wed, 10 Apr 2024 14:10:05 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id w22-20020a634756000000b005dc4da2121fsm10368167pgk.6.2024.04.10.14.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 14:10:04 -0700 (PDT)
Date: Wed, 10 Apr 2024 21:10:01 +0000
From: Justin Stitt <justinstitt@google.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Richard Russon <ldm@flatcap.org>, Jens Axboe <axboe@kernel.dk>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Len Brown <lenb@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Lin Ming <ming.m.lin@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, 
	linux-ntfs-dev@lists.sourceforge.net, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] [v2] acpi: disable -Wstringop-truncation
Message-ID: <b5ijucc7vbamdivt5o36zqleunihy6j62u3ecg6p4jgqmajao6@xatdncyyp6jv>
References: <20240409140059.3806717-1-arnd@kernel.org>
 <20240409140059.3806717-3-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409140059.3806717-3-arnd@kernel.org>

Hi,

On Tue, Apr 09, 2024 at 04:00:55PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc -Wstringop-truncation warns about copying a string that results in a
> missing nul termination:
> 
> drivers/acpi/acpica/tbfind.c: In function 'acpi_tb_find_table':
> drivers/acpi/acpica/tbfind.c:60:9: error: 'strncpy' specified bound 6 equals destination size [-Werror=stringop-truncation]
>    60 |         strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/acpi/acpica/tbfind.c:61:9: error: 'strncpy' specified bound 8 equals destination size [-Werror=stringop-truncation]
>    61 |         strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The code works as intended, and the warning could be addressed by using
> a memcpy(), but turning the warning off for this file works equally well
> and may be easir to merge.

Dang, I would've really liked to see these strncpy()'s dealt with [1]!

The warning is there because that specific usage of strncpy is plain
wrong. strncpy() is a string api and this usage looks like it has
arguments and results not resembling C-strings.

Not sure if turning off correct warnings is the right call.

Link: https://github.com/KSPP/linux/issues/90 [1]

> 
> Fixes: 47c08729bf1c ("ACPICA: Fix for LoadTable operator, input strings")
> Link: https://lore.kernel.org/lkml/CAJZ5v0hoUfv54KW7y4223Mn9E7D4xvR7whRFNLTBqCZMUxT50Q@mail.gmail.com/#t
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/acpi/acpica/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
> index 30f3fc13c29d..8d18af396de9 100644
> --- a/drivers/acpi/acpica/Makefile
> +++ b/drivers/acpi/acpica/Makefile
> @@ -5,6 +5,7 @@
>  
>  ccflags-y			:= -D_LINUX -DBUILDING_ACPICA
>  ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
> +CFLAGS_tbfind.o 		+= $(call cc-disable-warning, stringop-truncation)
>  
>  # use acpi.o to put all files here into acpi.o modparam namespace
>  obj-y	+= acpi.o
> -- 
> 2.39.2
> 

Thanks
Justin
