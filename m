Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D0E2BE64D;
	Wed,  3 Sep 2025 21:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756935169; cv=none; b=g/XJ6pu8RfWfvYctxFX/9M+7ynKENa1J4OAFpwc6NRAniVDEBlQFuTWaKbfj9cSSMn72NW0gyG7QTAfDP3ygHsFC7N4mAquA0piAhlUt8IkQFc99DLPzqFAGcVn+SCw7UXk5sfTy9bS2M28vGAVzcBUr515tZZnrMkm5cTqwCO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756935169; c=relaxed/simple;
	bh=PdLCzF0DByByZ8PGBP+flHVIYL/dRMgBFPRsO0VGpdQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XykLGMKzGLI220g/QZUrL/tM8CWQQcaGPGYOurlZMP7y8UjGDR7uTXTg+dVI3eVvpVG8imOxsamGfQsOM3gX6mcBCdOyj0QbsZZUXLWyxeyQAFE3EvtPXN3r6yS2UFU4muXq9eEjHLGnUhzq1UwJS3rLxZ4OrWpg53HGj7V8ssc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=pf5rt/2G; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="pf5rt/2G"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2FAF140AE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1756935165; bh=vzyLqfwbWFvCCDvBIM5lXqYLIe2UqeBnDeGY9vGSBjU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pf5rt/2G1Z1dDdzhLsTe9z+/sU50EdcT9l1PwoOmQzixKmwlEVUXpBApS+xE0qSY9
	 8VbjujxJwzeBhhGefswI6FiNftVQxm3OE3Xo8/vGddYqwnCO+rjGuvgkXURA/ylQja
	 sZfXEL5BUgByOYC78fE2NS3gSe1Skkqh8vu97IXyEULAd254qyovCvvLN8PtVtwUkH
	 ydud0cqlca4Tubvb5jXKyQnlzqLjX7STWYjlhAXf3TqlUuwp7C9aAthaXQkxLEuBLe
	 VJSKWT58JsxYM9Z0z0FAi37OE+2dYJETzIsBiPanUrV0q2SwvcKa9YfNSekcl0iK8b
	 XIzYUbSaeTpWg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2FAF140AE3;
	Wed,  3 Sep 2025 21:32:45 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Steven Rostedt <rostedt@goodmis.org>, Ryan Chung
 <seokwoo.chung130@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/2] trace: minor documentation fixes for clarity and
In-Reply-To: <20250903155209.058e22d4@batman.local.home>
References: <20250831101736.11519-1-seokwoo.chung130@gmail.com>
 <20250902102831.134a26c1@batman.local.home> <aLiH_zWPOsjMRs9V@gmail.com>
 <20250903155209.058e22d4@batman.local.home>
Date: Wed, 03 Sep 2025 15:32:44 -0600
Message-ID: <875xdzql1f.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steven Rostedt <rostedt@goodmis.org> writes:

> On Thu, 4 Sep 2025 03:25:03 +0900
> Ryan Chung <seokwoo.chung130@gmail.com> wrote:
>
>> Hi. Thank you for your comment. 
>> I will make sure to add the change log next time.
>> Please let me know if I should do it and make a v2. 
>
> I already gave an ack. I'll let Jon decided if there should be a v2 or
> not.

No need - I applied them and applied the tweak directly.

Thanks,

jon
