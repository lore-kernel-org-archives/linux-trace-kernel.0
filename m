Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA671F5858;
	Sat, 28 Mar 2026 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774720353; cv=none; b=RlqNDeQCdAawofw8kq4jBs7x39C7NkRwNjsIkh0xex5W6gdHNfepE+HD+6oPxmypqYCq0I8Iu1jSLlz5GMPHKLMgWWYlK/K3Lj5aR1+xuI6ox5HJzYALWCHbu560/pFpaJHHTt86wd7v1X1ug6mBJ4z7F+2oiQTojbTXIKXQuhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774720353; c=relaxed/simple;
	bh=q1Nz0KHu2YR1Z8+K+MSryGjIB25dBgKGaRsxofNgh8I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IY2B1csTLBlCsiyiHst6QWDeWYJg+W2g4uwMpU+aCj0/7xwH3Gvx3qZYSOO6d33ktO1Bg6YskncAtSDnubkDgf2Ku9L8FYLQmpSA7KqmjZQMazpThjOX/36nFbPhSKfjS5ZXOe1Ie7yeaEe6i9FADiFQE19SjKV2acu73JweEDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 905E0160161;
	Sat, 28 Mar 2026 17:52:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 95E6880011;
	Sat, 28 Mar 2026 17:52:28 +0000 (UTC)
Date: Sat, 28 Mar 2026 13:53:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wesley Atwell <atwellwea@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 tom.zanussi@linux.intel.com
Subject: Re: [PATCH v4 1/2] tracing: Preserve repeated boot-time tracing
 parameters
Message-ID: <20260328135319.3b22d756@gandalf.local.home>
In-Reply-To: <20260324221326.1395799-2-atwellwea@gmail.com>
References: <20260324221326.1395799-1-atwellwea@gmail.com>
	<20260324221326.1395799-2-atwellwea@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: zjjdfb7jfwohekubcxihrac6cszkyq4p
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 95E6880011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+DoBiA+HYUV5EaLYGu81gButRGUVixsCk=
X-HE-Tag: 1774720348-634194
X-HE-Meta: U2FsdGVkX1/qzFUEk4wYxfla5gvDhk3jseIAZmY3Fe3qhLzHzjnfmxu46JZqAR3+rhp63qAp/PXt6rVAaavj1SNLM6mlb2+h4AjYS1BFjajNpM9HuDlSrazlvLOvCksqLtHhtZmdHyl079MdsEAqhkBtN68kwBdxm/1RIutfBJWEa40vdmv/3s5txCLX5npnga+KdE7CNDAumxLuactVS8lZ5rkW3vXrOUeosq+NSM6JAX0BSD8B/x0+oV8UMJddLCY37i/6O2szqdU1aQ4riwVA5Nuy8bVHPkqTHDXb83MINpdMG648OFAz04jUyj32rlKZ9QdXE6cSS50bAk6YoE32MPyz3Vw2

On Tue, 24 Mar 2026 16:13:25 -0600
Wesley Atwell <atwellwea@gmail.com> wrote:

> +++ b/kernel/trace/trace.c
> @@ -228,6 +228,34 @@ static int boot_instance_index;
>  static char boot_snapshot_info[COMMAND_LINE_SIZE] __initdata;
>  static int boot_snapshot_index;
>  
> +/*
> + * Repeated boot parameters, including Bootconfig array expansions, need
> + * to stay in the delimiter form that the existing parser consumes.
> + */
> +void __init trace_append_boot_param(char *buf, const char *str, char sep,
> +				    size_t size)
> +{
> +	size_t len, str_len;

Why use the "size_t" type? Just use int. Then you don't need to play games
about unsigned types in the if statements below. The boot cmdline will
never come close to being 2GB in size.

> +
> +	if (!buf[0]) {

Should we check for size here? Perhaps just remove this part (see below)

> +		strscpy(buf, str, size);
> +		return;
> +	}
> +
> +	str_len = strlen(str);
> +	if (!str_len)
> +		return;
> +
> +	len = strlen(buf);


> +	if (len >= size - 1)
> +		return;
> +	if (str_len >= size - len - 1)
> +		return;

Instead of the above, have:

	/* Plus 2 for ",\0" */
	if (str_len + len + 2 > size)
		return;

> +
> +	buf[len] = sep;

If we remove the first check, here we can have:

	if (len)
		buf[len++] = sep;

By adding one to length, it makes the strscpy() a bit more readable.

	strscpy(buf + len, str, size - len);

> +	strscpy(buf + len + 1, str, size - len - 1);

> +}
> +

-- Steve
