Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F12B16F0EE;
	Tue, 28 May 2024 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902242; cv=none; b=lpj9koao2Cu6pJEJXv4Drr6qDRLZfv9YRuhEe8z6mwzv/CG6ApplEFATjf5BHYcE+9EEtvMNoNlUj3okQO/4gf9dYTUMnMgB+xV8ILj9gUcS+gLBDJRShiY+cEXujr/aCAHgKPah4jVEq2PhFGNVqe5sWwT/cA96W8STgywMCOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902242; c=relaxed/simple;
	bh=EK1dSveiHoYY2Wh6cOZ0/FTXClfWUzsByxRr6MHg0T4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkLnf/SCMIJOX2bpD9Z3LL3vq3j3ssr9K5LKwGGri+5pYYYEc91lBoppF3hJvnLUDzgYPiq7OgwnyAOpm5BaSxjLT8SWvR9sVNMJUDzv3tkGaJKMcQ/ChVnHtNxnTrN5TBXYCIFECeosWJhWERg2AEzdaEule0+J3GFZknP1i0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ots3NteD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ots3NteD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A405C3277B;
	Tue, 28 May 2024 13:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716902242;
	bh=EK1dSveiHoYY2Wh6cOZ0/FTXClfWUzsByxRr6MHg0T4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ots3NteDA8ROpL1Bno7PvK4OHeAwEeGCHjKDfZLzWMg6Yb0WSjkpiL7bOci1xOaVG
	 H6v3zIRfWssrFMvTk1dvPPEINAMeD9HOp7rJ9cwGMlx76CY2sQBanaJ1XhqFwEg6GF
	 CrPmVWA8AOIT2zD7DCbBOYY1A4hVQUWes4BX3bz936xxQwzh5djcpgKqhxN5yRUMsV
	 EnNRPQ51VNgJsw6z4yIjg7fksz6d8k2YpD/8wFGsaQS992VzkffbgcLPep162G579b
	 IrYtjmnhjudlHqudGimN7KtFK6DKkouLGGc/vbgKN8dnfPEdMC3uwkAQ7sKiIM2S0N
	 kfJCH3R05LquQ==
Message-ID: <815a7990-6e24-437c-986b-3c1161c7332c@kernel.org>
Date: Tue, 28 May 2024 15:17:18 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rv: Update rv_en(dis)able_monitor doc to match kernel-doc
To: Yang Li <yang.lee@linux.alibaba.com>, rostedt@goodmis.org,
 mhiramat@kernel.org
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240520054239.61784-1-yang.lee@linux.alibaba.com>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20240520054239.61784-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/20/24 07:42, Yang Li wrote:
> The patch updates the function documentation comment for
> rv_en(dis)able_monitor to adhere to the kernel-doc specification.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks
-- Daniel
