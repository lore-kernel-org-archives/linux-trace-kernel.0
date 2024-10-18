Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB751EE03D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262269; cv=none; b=r+5X+sxcou6mtYmBQRCmYq9milTTikC7EjNMjRf3GCH9fyd1lLe39yJaFjBW6Am2+5uSH3iXNxZft2mTnmzhR53uPnCcELuu4ySDgK9PvOn9OAy6GhysVdnQ/DxxQ7DodLIoLUpI69g2oMDb/CJc3iucka+LSju9wkebOcQaDNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262269; c=relaxed/simple;
	bh=i4xCrl+ZGKaNCww5ILdq3N5bOUNGkCc2F4NgMqSEJGI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=esBxz3QB8iVXH5Xv9DZhW3UkN0z4MifJpEbTs/y3oMpr3xc0Ix8fzYDFCCtG/SFe7qw9vC0v9oxIhu8uHVfrxj4SNBUVBEpY3BWJAeNH6D/xTWV+ZhZF0ma/PBjgYoTrkuUmGeiBgFHqocfXwWTfmUElnzeo8XbNvy3+Whu9f6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=QrSjm8lE; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="QrSjm8lE"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5FB721BF20B;
	Fri, 18 Oct 2024 14:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1729262260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y4dpHqyLLQIMOpKo4QAXo/P7kI56iYj8pXZBcdTpiP0=;
	b=QrSjm8lEYVpYkE/DWiAckn70ta8hAXLcNV/kgvrtcOEk2HsaZvhc2hhrZbRuKHSq4v5hiO
	PJa3wrenZVC0NaktOcv7ImWLqgvKWHLtBNOopiao/DLueaqpNW9lkakKaFzEjMNHjjb9jz
	j2xanEM0pI58/rZRewYyTg1WpurckAyu9rYPkq8pOPru65UuHRqLCaSXU8+8yDOeQL20Pb
	oE6Dq2jJfqjMD1GnE0tTirUZN78EZz5rfiwi6/A2/5onf0NZB9rizvJlUXfQB4DXQDOejc
	POUnQnc3Wz3b0UfDLwbagr3x/+6La6dgjjNO55TQr3NR6JlqEbmqH4M3/ktRRg==
Message-ID: <12dbe761-d2e7-4289-88b1-4b7d548b4e8c@yoseli.org>
Date: Fri, 18 Oct 2024 16:37:39 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, fr
To: linux-m68k@lists.linux-m68k.org, linux-trace-kernel@vger.kernel.org
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Subject: Adding ftrace support for coldfire ?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi there !

I always have been a fan of ftrace, in particular when it comes to 
latency issues debugging.

I would love to use it on my coldfire custom board (M54418 based).
I can see that it needs TRACE_IRQFLAGS_SUPPORT and STACKTRACE_SUPPORT, 
both are missing.

Is it not doable ? If it is, what is required ? Implementing the 
save_stack_trace() ? I suppose it is not enough :-) ?

Thanks in advance, as it would be a great helper !

Regards,
JM
