Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF8B30C629
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Sep 2025 20:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756843418; cv=none; b=uQMuSLmPmbm8RCJT4XdAf5R1+1phFO2dC8Xm1Jk9YONqWmZPl6dZM/A0S+PuLKeJSeJAjZBg1QzyjpbqwP3ZwV5uUckekhTgi30r/+vXjEo7Armr48W8zDSHeACsQ6HIQcbz5BMA6Fk1XkHM34tpk+KruQ2XXIS3xwW3l60tBPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756843418; c=relaxed/simple;
	bh=nqYjo+c3TExuTII3/IldzrPY/ERqW+m8zP1ABITcHM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jpj+X5HDbWdCahwMy6rBiGxTnJlrs0rWzxaL6c3YJFtMsxjehK6eTUxTUDk2ZUn29C9RMuL/XKjWbHW7EQliVRVfdXtvjaP8WlNGFAvdOsbTiCcElI4+gV1B1snf0UB6wMh5lxJPzA+WnJoWqm3pwvUxrTH+8F17WygPCHxkP08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elijahs.space; spf=pass smtp.mailfrom=elijahs.space; dkim=pass (2048-bit key) header.d=elijahs.space header.i=@elijahs.space header.b=b2lFybW5; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=bXOkKmCq; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elijahs.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elijahs.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elijahs.space header.i=@elijahs.space header.b="b2lFybW5";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="bXOkKmCq"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=b2lFybW5y01/0cUn2gVbkjfm6KYePL3oZlgH6K+N3GQBubcnAd5XfnIkeq037c4eGkvDXPmyLquyV/5ob3mYwwt+y49Y3MK2manCk5RzjKlcWrQdkyPPV04zXR74y5QXIJ/mmVuymCxmTCeZgIwMCE0QWn4uiRcb1BtKXvKxk4cKfZpCPIxKfQVGJHTPqnZTvT9Vvxs+XuyHZ1hgkxy0JXsB8nZhIegAkHTws2jnVf9lUX4ls/HrGXlhpvzVIaCeKaMq96qTI7i0fgw6b4wYOsaWvyxKWRDwA+Ynf0hGOv+jreHdImShr9JTB+grWSXncXo8FNQj8K4LHa0lw2WMgQ==; s=purelymail2; d=elijahs.space; v=1; bh=nqYjo+c3TExuTII3/IldzrPY/ERqW+m8zP1ABITcHM0=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=bXOkKmCqIFFN+cka0/+WgWKf+Imvhoh08kBrT0Hdddz4gl22lg96SPr8q1wliEjKw/iduxnxHUia+a+EyNv84Od8YvqK7NAT75jS7cFlbIdCT+HKBGGj22KFLSeeo4PG+A1HzEAM4p6PfDvAB1sutgpIn6Fu8rNsEYRs0evYQjF9zjY0shtKAvPDmy4mQaLW+CuX9y4+OWMlhEgek1z38Z06q+QN+pmP3tTMQ/9B1lj4yVXG9qPCgWKIwpPWkZTSkhgYpBWvpzR177yS+8R8s1xNkVGRcLtpfG+klZ3OPG5GMzTxWSKnBtsEnK9WNc7zBLCk/vSUptx4UPfMwTjdUg==; s=purelymail2; d=purelymail.com; v=1; bh=nqYjo+c3TExuTII3/IldzrPY/ERqW+m8zP1ABITcHM0=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 26912:4866:null:purelymail
X-Pm-Original-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1514646534;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 02 Sep 2025 20:03:20 +0000 (UTC)
Message-ID: <4be8fdf0-9cd8-47cd-a37b-b41437e3e63e@elijahs.space>
Date: Tue, 2 Sep 2025 13:03:18 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: move buffer in trace_seq to end of struct
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Elijah Wright <git@elijahs.space>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250821053917.23301-1-git@elijahs.space>
 <20250821114355.6ee546b0@gandalf.local.home>
 <20250821115359.3988b807@gandalf.local.home>
 <ce062d82-41cb-42c0-b970-1312dbcd1094@elijahs.space>
 <20250902160020.5cd24fce@batman.local.home>
Content-Language: en-US
From: Elijah <me@elijahs.space>
In-Reply-To: <20250902160020.5cd24fce@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

that could work yeah

On 9/2/2025 1:00 PM, Steven Rostedt wrote:
>   struct seq_buf {
>   	char			*buffer;
> -	size_t			size;
> -	size_t			len;
> +	unsigned int		size;
> +	unsigned int		len:31;
> +	unsigned int		full:1;
>   };

