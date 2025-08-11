Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2561D1E3DD7
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909351; cv=none; b=rbEtMunOJW4doVseo/a53Sf9VafY6vqNYLrKZQT/dqC0r9lpOkZ4MxN77C3ub2P+dhxYrymzq4+fnzZfjnht4YtiEgJ/rrUw+YR4dRjWSvVPyqW0KsqQT3mqLIiwPrA3kaL6OJ+qrtN/LbCqbz/Jhm479+do3bNJTfSq4Y5irss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909351; c=relaxed/simple;
	bh=WKObFWIHeQBicsruWNzn9xqhX0Zs8CeGMF19cPRqKow=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=STvrr6v/Z39WOy4f7AkCzlujjP3u2zAG9OXSg4/tPeksMuy/FdNMnSG+fbyLNIhUODrrM5OzkMVMVFj4QX0AA/bANdAg/nYvEfykrV28YUM78n9SBSHu7QxijF+dv8IkGTsyrvrrZvQCy58VTr6lh29lCDWOIzZYuxEMS7rOD7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QTtqf853; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTtqf853"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754909348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WKObFWIHeQBicsruWNzn9xqhX0Zs8CeGMF19cPRqKow=;
	b=QTtqf853hViejxFS3XZykqNgPlCq4OxxNYRsCLJczfLvCkB2N2rk7hVZWR6vOw9IMPkZM+
	k8ZToJjJkjxuYPBanyHJElqYLdc+aBkRZpKfc25d3UegFKXfYVrYXm5DB3QJXDDJrXNGyR
	lOxlZvwHVM6lZGdxovvB+7voaUnuyNg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-Uh4MKUspMtyJTxUlESlDZA-1; Mon, 11 Aug 2025 06:49:06 -0400
X-MC-Unique: Uh4MKUspMtyJTxUlESlDZA-1
X-Mimecast-MFC-AGG-ID: Uh4MKUspMtyJTxUlESlDZA_1754909346
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-af9a8a53e75so248802666b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754909345; x=1755514145;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WKObFWIHeQBicsruWNzn9xqhX0Zs8CeGMF19cPRqKow=;
        b=UQitaAjChArYJQtBhI+PS8Hj5rCugag8rk+o0NwJH7d0QgT18yf4pcwm73vF3D5HQv
         iRF9pvtBxjA4oWNhfql698JWMdmq7VVYb0mtRf0jq3PaUO5SnjvjH9jElxDJ6FIxE+FQ
         pNHGeEDlQTAJx0IYxEXkRjWKzaZOGT8HA+BukDK7Np6/Yw/9+VMqWaM0MVkFFd72yKnd
         +OfRSUsgLjKEmtdoXTt3PafOlDHy4YIFcNRqS2wxIuao2GrkhQdo8bowFTjzFGuOJGa5
         n0KntJj7f3DYkhc7FYJSbJBVHdaaNqlUd5fE08cKwVQKXRPe1eR18qqHuEifipNDvQJs
         hO6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuMG6NHoh/2y6nnyjoQ30c9WoKpL+PjhEVyT4+lRtTwy7J4NTwP7FjCidxETHgvEwj9RbwupF8PDvhmxwZT9MDkdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgdjx52YzFBm3Kux0tFBHXHqv5yEmhob2v0nJ82T+67Zdbesor
	XJOxBZK8QdrUH7FvabhgGvEK9vhhYuzWqkvWQgZaX1MVj2YIVLWHKRcqRgKqaIt8IvYhTOK80QN
	72bkmrhF1n4CYvT7295AI45C33bSVqTC92fVKznZMMUqiJfo5IP3AQMnO+sD1oCx20c4d+PiB0K
	BoC48FRZP/
X-Gm-Gg: ASbGnct98n9Jhj1KI9+iCWwl6JRnkaqT8g5DSjS2LjjZYgy6n4V6rkTOezoPv0ozof4
	2ZHYCOha+y0FFcy0uUQwVeQmZJzQWeHaPvv3n4IlHWKQerp2mE1clbqvQr+adqnN5JTwWg0PgZu
	yvfFLfSubrwri0eWZP7a6r9i11HoYtf7JLyF9F/kjFot7GdzOgU4Uadp5/WkkGb9FVWspOgbI+S
	ua230jO/UmZbZt6I5yag2q9REvFYXDBdvtsQJhx0QSfADzweP7O9zgtI7HmtPhmT+xTuIgES0fX
	AQSv3x/zAIdaEXVplJa/+4mKShYnwgM0CklUBw==
X-Received: by 2002:a17:906:4796:b0:ae4:107f:dba2 with SMTP id a640c23a62f3a-af9c645b69bmr1064762966b.13.1754909345650;
        Mon, 11 Aug 2025 03:49:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZCDWpvyPfHXfxgwBBapGqgujydR1xLydnPbVqezT+c6mpdCVAhjCJgUFH79mw6d7KM9b5yQ==
X-Received: by 2002:a17:906:4796:b0:ae4:107f:dba2 with SMTP id a640c23a62f3a-af9c645b69bmr1064760066b.13.1754909345163;
        Mon, 11 Aug 2025 03:49:05 -0700 (PDT)
Received: from [127.0.0.1] ([195.174.134.174])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a1251sm2006600066b.30.2025.08.11.03.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 03:49:04 -0700 (PDT)
Date: Mon, 11 Aug 2025 10:49:00 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Message-ID: <30f0e085-b636-45be-960b-68bf6a136f59@redhat.com>
In-Reply-To: <aJbsYkON4V4iFPFG@bhairav-test.ee.iitb.ac.in>
References: <aJbsYkON4V4iFPFG@bhairav-test.ee.iitb.ac.in>
Subject: Re: [PATCH] include/linux/rv.h: remove redundant include file
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Correlation-ID: <30f0e085-b636-45be-960b-68bf6a136f59@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OwP7OK09-Z-2ddTAGxa1NZWY4XZw_0YwPMSxL9XCt3Y_1754909346
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-08-09T06:36:58Z Akhilesh Patil <akhilesh@ee.iitb.ac.in>:

> Remove redundant include <linux/types.h> to clean up the code.
> Fix this redundancy introduced by commit [1].
>
> Fixes: 24cbfe18d55a ("rv: Merge struct rv_monitor_def into struct rv_monitor") [1]
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202507312017.oyD08TL5-lkp@intel.com/
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> ---

Thanks for the patch!
I'm really being picky here, but, since you're touching this, isn't it cleaner to keep all includes inside ifdef CONFIG_RV ?
When CONFIG_RV is not enabled, the header only defines constants so it doesn't need other includes.

This would mean you could remove the other #include <linux/types.h>, instead, and move the #include <linux/list.h> down.

I think you can keep the Fixes: tag and make clear the reason for cleanup in the commit message.

Thanks,
Gabriele

> include/linux/rv.h | 1 -
> 1 file changed, 1 deletion(-)
>
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index 14410a42faef..8b968b8ed77b 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -15,7 +15,6 @@
>
> #ifdef CONFIG_RV
> #include <linux/bitops.h>
> -#include <linux/types.h>
> #include <linux/array_size.h>
>
> /*
> --
> 2.34.1

