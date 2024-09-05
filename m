Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D661119D06D
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Sep 2024 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555612; cv=none; b=o+i5EYE4wHek9YSL+w456HBU7VdGRII/CcYCQuaIL4cOAHfYn0PoaZNlf9+0jRFCaH25cAR7Je5RHEF++pqJr3Opp114860JmyjUU9XEQUVtPraw8flXWfzAlvXxshmcW/RDfZliDig3zmOLWeAJAyOIcqtKJXps66PoW88h7qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555612; c=relaxed/simple;
	bh=n/KPK3a86ME+wOz1Xv535zSdHyS80uxvl6IV0IJZejk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHDT+9cfTx9KO5qRozclxjN8VWP/So8cWPruu59CsBqgFlpIimJLq6KlAMlnkMHmxOjp5EW7d3NWgQg/sUT6Sq+i9VhsytU6WiHn6LJJ+w/rt9UjyWquTBNg8qjVIWgcfbNE2/xDP3grmrXYrXIdDcOabJvJe7jxA8HrVYLeu6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=URoleLV0; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="URoleLV0"
Message-ID: <e0ee5f87-bdb7-47f0-b252-04006b54dfb6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725555606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/UmgDkDmAWdFqvPvihM/s+zg6KzYkkAcVIPnsn26T5Y=;
	b=URoleLV0niqYgJb90s9S8Z2PRqWqR1MJmHipc8lUR7nJ7ov91piQoFU616oHbz73DjFwCa
	gsdX7jIszLH3V5ykWrEG5Rzg1hj6CrQktCDcNSqu3N+SF7u5NWhCho3UoMsIxfpjwstVxR
	wtfdfXYwXSLt4MZOA+ppUiYivfqBHk8=
Date: Thu, 5 Sep 2024 13:00:04 -0400
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] dma: Trace API
To: Christoph Hellwig <hch@lst.de>, Steven Rostedt <rostedt@goodmis.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org
References: <20240826203240.2234615-1-sean.anderson@linux.dev>
 <20240829041912.GB4408@lst.de>
 <4c2c6b24-aee1-495f-ab47-662e1e818f4b@linux.dev>
 <20240903072512.GA1521@lst.de> <20240903092154.5f0bfafe@gandalf.local.home>
 <d8936bfc-1ea3-4142-8035-0dfb8e491c31@linux.dev>
 <20240903205322.69d7638c@gandalf.local.home> <20240904041522.GA13349@lst.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240904041522.GA13349@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/4/24 00:15, Christoph Hellwig wrote:
> On Tue, Sep 03, 2024 at 08:53:22PM -0400, Steven Rostedt wrote:
>> This should do. I could get it into the next minor version.
> 
> Sean, is that enough for your use case?  Otherwise I'd keep the
> unsigned long long for the _sg array, and use the proper types
> elsewhere.

Yes, this is fine by me.

--Sean
