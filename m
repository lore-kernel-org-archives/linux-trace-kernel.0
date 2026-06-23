Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CFA3A6417;
	Tue, 23 Jun 2026 20:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246881; cv=none; b=iGL67FZGGDE78yNNd2QPSVN1NpfZJczORyhwmEmHqIMT1QmquFy8zB1kRjmy4RdCTMIA8sOwkPUlBjICYQJKjDmSM62TDsOCEYiB9uHg5963uu+bRa47oNpogy+fci/PH3YvUHU+eLNXiT7AqZtW5hN1v9TjLnz7TeDORUSoKK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246881; c=relaxed/simple;
	bh=x2aDEwiyNGys2YUAbIqNKgX0lAxgo3Otaa9eAttDU5M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fVeCgjTpTsY6hzmzwQFxxjATrYqusJ8QngQxqdbeWwherPoDlMfb3hn4dYJgGxeYVRzoVoS5N0s0W8Kr+WF9Rmu8yB5/U+gng8jW7qPp8cVy/goIgIGeSfx78bfqwlKGsbB1GFQFUllDSfhzBV+hmO/mF3IfeIHJ0mbGngYmJIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=d4oop37f; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="d4oop37f"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0879240430
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1782246880; bh=h1boQ/dW/mADxq+WJyv/QCTJlk7q1L+QoMvXEZJbtQk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=d4oop37fHhHemN7KR+5A1dMx0pKmhjOyGvJS7AUNxaOzmwqwdYztPf3nLiONU9qui
	 j3n8cKnARukHujRX2a5yNc2QipmHjl7Bj+HL8ZNv3uMp3Gnz2ScfMW4B4Q7wZQ5nFL
	 ZwCwgU3Jn7imIeBXlvXzaXNC18ua58NgdaguOZmuzBVU2jGwsQVtHImdyNm6CASRYJ
	 KNYBYLaurbhy59/cxicHZna/u7Iuok55cVmAeZR51IoFLoz7h89iq3e5bB/3j4qFxK
	 eMiRkKGwI9kLubkx6i8eDcDi0k9TkiTaQoXdWrKmKUXO+u5fDnDkHGJupKeEHJ33RD
	 rFmgPTsXNEJlQ==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0879240430;
	Tue, 23 Jun 2026 20:34:39 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Yudistira Putra <pyudistira519@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Yudistira Putra
 <pyudistira519@gmail.com>
Subject: Re: [PATCH] Documentation: tracing: fix typo in events documentation
In-Reply-To: <20260622143735.71778-1-pyudistira519@gmail.com>
References: <20260622143735.71778-1-pyudistira519@gmail.com>
Date: Tue, 23 Jun 2026 14:34:39 -0600
Message-ID: <87echxatcw.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yudistira Putra <pyudistira519@gmail.com> writes:

> Fix a typo in the tracing events documentation: "can by built up"
> should be "can be built up".
>
> Signed-off-by: Yudistira Putra <pyudistira519@gmail.com>
> ---
>  Documentation/trace/events.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
> index 18d112963dec..581f2260614b 100644
> --- a/Documentation/trace/events.rst
> +++ b/Documentation/trace/events.rst
> @@ -1064,7 +1064,7 @@ correct command type, and a pointer to an event-specific run_command()
>  callback that will be called to actually execute the event-specific
>  command function.
>  
> -Once that's done, the command string can by built up by successive
> +Once that's done, the command string can be built up by successive
>  calls to argument-adding functions.

Applied, thanks.

jon
