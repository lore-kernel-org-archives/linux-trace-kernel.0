Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659C9274658;
	Fri,  3 Jul 2026 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783095901; cv=none; b=iUJyspSx9S/PDzp9sbY/iUYqngKlqW3ZqT1pkjQtS80uJlQn3dMET9Yh/g+pB/Lri4R3mMOfs6fC53W4NYIECLfFD/l7n4sxcDsFSIi8G/IS+212QaNRcxJzsrIf6BJ1CMZkvnQrYiceJ6GMwrzr5GJ5lj2PAdEifP/I4VCLdck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783095901; c=relaxed/simple;
	bh=SGFHVX3wKsKDD25bKl1/Be3/WVHTkYigvzrUZKFqciw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4EUB7tVu6ZyFTa3zNDRmWsuJWu43hl18dZ03XmGyiwp4QpcS/gQnIe4RqSyBT5Sj0wn5EsmUwbrTCaKN2zlOJL5UP21wfwgj6qKpX6+yYShncBaOIUKq0qGqESDtA6CWcCVc6/XzQ6BxtIn70CnHgSz8RTnAFpWnj0JAFLEU7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=VsZOv7TR; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="VsZOv7TR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Reply-To; bh=zWgDBDMiFkqOG3MbdPkXNRyhTRRr72fK17KFTVewuHg=; b=VsZOv7TRCc2tPEt1
	a0y7vidfwo0SF9lU/vCNnHdAdchQFzm8gq+fs/oAgMNaEGmYJR3Lmd2yhH7xd15SDY0/E/JwcKQ2y
	QVpZTQSfoz4hllUFw+/U66A7j0zcWlLndj6Gbi4LTO5HKrxJJNG601i2zZkIRIalrlZ8sJmrVg2ae
	YWNPr+ip1anXUo5ADNuvgbS3fPr29tQ2eLzGKl+OYinOcHttjahtHHkJsrbPhwThW/N599mOJuv6h
	ypXctxksyW4oFBuv/MqQQjoOoHbj8Zc7k8nzyPSPukpPljNfeBQzMqIEyGX1veHRqkhp0Gv2gfFvb
	m7MqvVEDXWg/sJ2TTQ==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1wfghC-00AfYx-8K; Fri, 03 Jul 2026 17:24:54 +0100
Message-ID: <0f8c29c8-e395-4bc2-bcb2-fa971c38de6a@codethink.co.uk>
Date: Fri, 3 Jul 2026 17:24:53 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: make tracepoint_printk static as not exported
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20260617105822.904164-1-ben.dooks@codethink.co.uk>
 <20260702184658.0e0ffb02@gandalf.local.home>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20260702184658.0e0ffb02@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk

On 02/07/2026 23:46, Steven Rostedt wrote:
> On Wed, 17 Jun 2026 11:58:22 +0100
> Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> 
>> The tracepoint_printk symbol is not exported, so make it
>> static to remove the following sparse warning:
>>
>> kernel/trace/trace.c:90:5: warning: symbol 'tracepoint_printk' was not declared. Should it be static?
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> Thanks, this became only used by this file via commit dd293df6395a2
> ("tracing: Move trace sysctls into trace.c")
> 
> I may add a Fixes tag to that commit.
> 
> -- Steve

ok, thanks.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
