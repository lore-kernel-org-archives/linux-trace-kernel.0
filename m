Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ECD2E36EB
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Jul 2025 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292802; cv=none; b=kA4QGV8mPBypsnYPhRQZFGaR//nXNA1SIrCYtpddn22UIziFhuzrPJSmUJz78luv7NZVvtgeuU51OZVPrjTYzwTs09ugzDhz/9RVNA7UUTyrmzboKnJxp4V4w3uYGMORBLpTJHCN7DOPCKdhLmgfPB1D66r0sHjudzxOguBmMK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292802; c=relaxed/simple;
	bh=lYnN/1pWgCDFqesfgHtQyFbqwYH5n9urVKcNuI5vi2U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cOIr4EZ7yUOyHQAxNLkSTv1elCoB36JpRYP0dc/nSk8uudlfuV5g5Yjjgcc8VkBj3T+P+MfNb/o3oa44horbWyo5Z0edhjE0Vb/bWhyocvaYXz5bcYy4tZ+EhTYBJwisWP+vqMd+Aw9BkINYWwCCaukuB9n2N2czIrT2sdcbRW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LUt56hqD; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LUt56hqD"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753292788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ug2rfeed2cWn/I2/5Z5uz7sqeV+pd/xv4VUaRzto6qs=;
	b=LUt56hqD5CCboMBaMivITHWY7Oc2uO6Si5y3LPXwB5Xc9XMSAE47X3dVjalNudEy07lIny
	4E9d9p1dWJ84BmnT2uNOdBpR9+/DoBpn4o8f5CIUsSzDq7xu3D8YcW0SIAchLEf6Hn9FRB
	hjVpu54skIoUfoPzX7e13KLNRx4Z8rA=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH net-next] tracing: ipv6: Replace deprecated strcpy() with
 strscpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250714123825.6f0485c9@batman.local.home>
Date: Wed, 23 Jul 2025 10:46:12 -0700
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Guillaume Nault <gnault@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@nvidia.com>,
 Petr Machata <petrm@nvidia.com>,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F998F71D-1244-4154-BC5F-19201C23BDBE@linux.dev>
References: <20250714075436.226197-2-thorsten.blum@linux.dev>
 <20250714123825.6f0485c9@batman.local.home>
To: Steven Rostedt <rostedt@goodmis.org>
X-Migadu-Flow: FLOW_OUT

Hi Steve,

On 14. Jul 2025, at 09:38, Steven Rostedt wrote:
> 
> Hmm, why is that string hard coded to 16 bytes and doesn't use the
> dynamic string facility? Perhaps something like this?

Your commit fca8300f68fe3 changed it from __dynamic_array() to __array()
and __string() seems to be just a special version of __dynamic_array()
with a length of -1.

In the commit description you wrote: "Since the size of the name is at
most 16 bytes (defined by IFNAMSIZ), it is not worth spending the effort
to determine the size of the string."

Thanks,
Thorsten

