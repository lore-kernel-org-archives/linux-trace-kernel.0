Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F08389DE3;
	Wed, 24 Jun 2026 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782285355; cv=none; b=ODRaK1nhQpPPsMhw6YlAFcx7AIgeL0aDjuk+jZPPVwzGv8D7+tUbV+wJw3XrRLYfER/pQgz/6T9DpshcexaWWzUO+W01KxDd7Hx+1f2d0yM2kcXhKYgY2zQ0HdTvQ7iR/VS3VZwPyRqg/HSYyZnuI/YpziQAjoJ5Pync8eXtqpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782285355; c=relaxed/simple;
	bh=PfYTomWWcI7PSFeOzKdEGdH/2MiubdyKhna/WEa7cY8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=IIOcHapx3zkwHw8ohU60ea/q15+Esaej86mQ1NfMFq3XRASxetpAySD+VWXwPVrWNvHPcZw9A73xuU8r42MBlR2AghmGB7iauio7Q4d9/uMaTJikQExJM7e497qolZkihq9xh/u82C2RmHG18Ffxz5IlKeQBUNKQYnOsd2IbF+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=J9g94jE7; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="J9g94jE7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1782285325; x=1782890125; i=markus.elfring@web.de;
	bh=8dOWp3pV+ZefuPVZ5j2qaSzkQVlLtzcYfZVuW/HNwQ4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=J9g94jE7rMX0K2jQ3lJWegOVx841SU9oOhKPqhBVvkHGX4PGZAe+gz1Cuwgr2bPu
	 MLwbLGefYPjjeWARd416rbdJ2mnJlABM/7CG18I3RpRFKmn2i/YzgoNR2dGRvuUwf
	 mgXq4CTDV183qn/PnUh/rdQrtPo0N7/V4QcOfMofeyZJXLwbZpBxPQHuSThDHUxYX
	 Rs59Zd3mZYhtB6jR2lT/Q800hhsXXC1Cp+EnHTrVqz/GJex0QDpY427xyIyf1H4ey
	 HFCHEjKYXdIjq+DpcBOpX3/arpfhYB/Jwv0IFKtgOYOmdyDb/h/fJt2iYIHOzTVgs
	 3zLlasrhmDICwIwJ0A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdO5C-1xBLbB1KDI-00b2z7; Wed, 24
 Jun 2026 09:15:25 +0200
Message-ID: <53c33d57-6619-41ba-8963-604337ae35db@web.de>
Date: Wed, 24 Jun 2026 09:15:22 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>,
 linux-trace-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Brigham Campbell <me@brighamcampbell.com>,
 Jori Koolstra <jkoolstra@xs4all.nl>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20260623145147.12145-1-woradorn.laon@gmail.com>
Subject: Re: [PATCH v3] tracing: Use seq_buf for string concatenation
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260623145147.12145-1-woradorn.laon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TFiC94XlxxqZbGdb/y0wk5frxVrXTtU05fENh0OowrVa8K9pe8u
 QtadBkms3J9BH2F2OZbXKcwFP9m0nBHFFsYe/dmzHELGntnSv7fr8HrFX4MQbHw3UabxIvn
 j9Zeuwqyh3PuA6/IO4h6Oy9P3fiixSjPlU1hHTnQjWdW8UiLmKByr+hwzUEX0cVSXwfNbOM
 gdP8oT8JBx9r0CwKd1dDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bGMsl0RDInQ=;s6ChLshfZgchcskk+rGquto+txl
 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

=E2=80=A6
> +++ b/kernel/trace/trace_events.c
=E2=80=A6
> @@ -4501,13 +4502,20 @@ extern struct trace_event_call *__start_ftrace_e=
vents[];
=E2=80=A6
>  static __init int setup_trace_event(char *str)
>  {
> -	if (bootup_event_buf[0] !=3D '\0')
> -		strlcat(bootup_event_buf, ",", COMMAND_LINE_SIZE);
> +	if (seq_buf_used(&bootup_event_seq) > 0)
> +		seq_buf_puts(&bootup_event_seq, ",");
=E2=80=A6

I suggest to use the function =E2=80=9Cseq_buf_putc=E2=80=9D instead at th=
is source code place.
https://elixir.bootlin.com/linux/v7.1.1/source/lib/seq_buf.c#L203-L221

Is there a need for corresponding error detection?

Regards,
Markus
