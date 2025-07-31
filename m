Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1B321CC6D;
	Thu, 31 Jul 2025 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753954090; cv=none; b=cNIDOEd8UVkBNSiZmXxQf/ehBrlTTiJWs2kgsZCZBtQ6PtrmUSrH5q34c4yleIPuWoq05fqQJJ6FWH8oc18fKVSp8gOCWbuQrkDhwb7rxK84AL6/qaeBpXM6wHSHjxfy3zRYunEfgGrzZRrw+5zsJVYhvaVGy27xxbyLwcJ7IiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753954090; c=relaxed/simple;
	bh=lEHFUXAyu0vdgj8Un+AXcSqHZmlkgPOd1fU7kCyEeG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fI1wMOsDTAJUCHE7PihlY4TYUo2WyEAX+n2jqiNDES9riVxozBJTiaZr1LvCOTEHt9zFvsYd+e/f1VTyzAegJlueGQRooSPbKpPcvzREmdtebGSEgUBMvZcCLBM9kKwoz5iPZdy9+KpviJwW3zIMGojUmCi1uqTfnxNVA7rGFHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LGx5i7td; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZpPnX2lR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LGx5i7td";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZpPnX2lR"
Date: Thu, 31 Jul 2025 11:28:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753954087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tlihlJWyxGcHZ8Zda5GK7TpTveqT1EIEWz3N7KlLYVM=;
	b=LGx5i7tdSuPAjoHXF93+8bWXUnwjNzrvQRN9DlMBmtrEsg7EMXGCCPRIXXw1h8FDC6rdTS
	b93QWjaMLX8mQdWgxzSbqcU+Y3WK9HWEe8pGVbQNopwfCKc/+RkwQ50168KBmleCT+CCqT
	RHGWxf9c513Qbfdi+4DHMZ8aCPqljELgZn1RIIbJKIshJudzq22EZizTgpNMBAz7RqfIVw
	pxQE9Q2A0HoLeEmRxX3qpvXdYSEEFNVpCazc6HHrVz/SFL2ILQjJ6esdgpJPwa0KPh1q0a
	kNViiEV6LBrmKaQahgVW4OC6ZyV9gKUdQCq0k+U3ngWMkzb6dET2WsfS8CorlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753954087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tlihlJWyxGcHZ8Zda5GK7TpTveqT1EIEWz3N7KlLYVM=;
	b=ZpPnX2lRIihx9jPOhMt3ubraT6ndQ5yPPT+28FXg2+j8eS+f8yBB3RMm2uxPOk6Gm3pQgO
	3XZtdyx1UclMpsAA==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] rv/ltl: Prepare for other monitor types
Message-ID: <20250731092805.EjcyYi0M@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
 <0d13c61bc6e0dc82108995c9a1d140bad4082039.1753879295.git.namcao@linutronix.de>
 <adeb68b39e8b468da685bbbf3b453f947fe2336d.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adeb68b39e8b468da685bbbf3b453f947fe2336d.camel@redhat.com>

On Thu, Jul 31, 2025 at 11:04:44AM +0200, Gabriele Monaco wrote:
> I stole your solution to get rid of macros for the DA as well (might
> post it after this merge window or with the next changes) and I'm
> currently running with this:

Nice, glad you like it.

For global monitor, you could do

     typdef struct {} monitor_target;

     static monitor_target rv_global_target;

I didn't check clang, but gcc does not emit anything for this. So
effectively the compiled code does not have the "target" parameter.

> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index 14410a42faef..6a7594080db1 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -13,6 +13,10 @@
>  #define MAX_DA_NAME_LEN			32
>  #define MAX_DA_RETRY_RACING_EVENTS	3
>  
> +#define RV_MON_GLOBAL   0
> +#define RV_MON_PER_CPU  1
> +#define RV_MON_PER_TASK 2
> +
> 
> The numbers don't really matter and you don't need to implement all, of
> course.

That makes sense, will do.

> I'm not sure how are our patches going to coordinate,

Let's just post them. The one whose patches are not applied first will have
to rebase. It is a trivial rebase anyway.

Nam
