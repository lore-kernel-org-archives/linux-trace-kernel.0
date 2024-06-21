Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9359127B5A;
	Fri, 21 Jun 2024 08:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718958377; cv=none; b=K9knaikphr8yeC5buDDqil+cT9gUBMRzZbO08VebZbD6WSWTy9sQPWEbsKcT9qslKPAxYJE4OR464psLI95g0ECwDvfEQxP24fVN2en+zxVf7Gb5R3EcLK9RWGvPX/0Ua1CZYWX5Uv1DWAI45lggiqqh9OkbIaXHooe9J+otme0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718958377; c=relaxed/simple;
	bh=/hw/cyBWKw+cGE8rw6PJ47hM/bF8yvCPo/6BdYESbyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JCJFXxEwcySZoQEllzUzc5a1MF7q+4sS/kJQLsWPd6Q/rtbFin7U49zYduapaJYbgxHF/5QSFr7JpXpaU6Sisf7Ypbm0HMptmjZyWUjg9Dt+XPk0ZajXU04bUSr7tdGY3ko8Tp2cmqBGEvTuA+h2RkMThL+uuF4fl/z+DtsgCgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFDaiIWU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFDaiIWU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92889C2BBFC;
	Fri, 21 Jun 2024 08:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718958376;
	bh=/hw/cyBWKw+cGE8rw6PJ47hM/bF8yvCPo/6BdYESbyM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nFDaiIWUM2YDPWn1xMs5a3Tu12olYonZn56Q52gvXcOlFoPbJVAnLuetdr4o3kXVS
	 9v6EQGilQbpXTL46LeKk2X1/bMYCEwW0tOU/S6b/BKxPQAhPjCh/UTDZqYNCFjMfWT
	 NS9dxfFZmoNb6YgG7bARmNG/D1XLVMpstjRoeqZdW6DUwBDFgz5xzA2lbpEACfuSVX
	 +3NDxvEyq05/Us8sxUzHdGUFCfVSlXMMhrRK4Qqrj4vSgdcDpL3d/BkUqL6emyi0XI
	 vjaEhvqK0SutauA1rKosxCvqMGhLBNZqy1YN8Y77xWWTVZMGF17f7eCe0hqDuiln3a
	 WnENW9AJprtjA==
Message-ID: <8ce9d171-4120-4129-ae70-6a54342e0922@kernel.org>
Date: Fri, 21 Jun 2024 10:26:11 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtla/osnoise: Better report when histogram is empty
To: John Kacur <jkacur@redhat.com>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Clark Williams
 <williams@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <Zml6JmH5cbS7-HfZ@uudg.org>
 <9d283173-4ff6-fbac-bcc3-e712daa99572@redhat.com>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <9d283173-4ff6-fbac-bcc3-e712daa99572@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/24 16:12, John Kacur wrote:
>> +		/* There are samples above the threshold */
> IMHO The comment isn't needed because the variable had_samples is 
> descriptive, but it's not a big deal either

Yeah, I would not do it too, but it is fine.

I am adding it to my queue.

Thanks Luis and John!
-- Daniel
