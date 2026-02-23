Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799B323E358;
	Mon, 23 Feb 2026 21:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771882451; cv=none; b=i1WJpWf13rpkO/6Fa+HNe1RnEa6FSuXKR4pd4HdawF8MTeRkM8lsd30cmsaJ8pGIjNaAcc2t9H+JEJJsN29lR67JgFrQgzzn1PyF7ACS6LVo/elpE2EIBjPq2AgWnrGpKnyedEcIOZBEzknis2qVLLqQJ74KBg3syHD/E5pHTTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771882451; c=relaxed/simple;
	bh=yW66PgtS7TMre9iYZz+uBZ0gFAxpvkrZNFy6mTKxGfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JQR/5j2ZUn7Wtwqc5vmTWaU+fYONlSJO0uDv0iblth+SbZrOqkddwTZc2bhxvcXuxVKVLqMlvEyp0w9PnChYuNBXWBFiq1w7dtAk52t8pql+k+4XX/SQtsTxoC4+yTa3SQpfVgiFzalHjPTR41CadG9JBZ35IbOJK/3ZYCTz4hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=L157LcRL; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="L157LcRL"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CC52940423
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1771882449; bh=yQ6eEVYkWITfriAUX0GJpHRcPOumgnFsSFkBjRLVNeQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=L157LcRLHL/yOoYo7qeCHINg6d0cRNjzh/h4dIV5WAqpP00qKnRGNjfzT0vn88UcJ
	 QdEcTW9XqGNaZg5RgamoYBivN+hnAvp5TpFSHUWz955wApnsOJIdELUNunmXO/dIQd
	 aA2dB79wZ7oDAcoKvPPiJRqHSYxzwFaIJ+m4pQQkJLIIq4wp0h0bNyeTD5dCi5aSBn
	 6Ptsj9vUWSOhEutknFJPh7fXTgC/1usHZHcLZpqRFDz37nC6WNyBK1TOYHJ6wmVssH
	 CAdCfxeuEeTNIES/dOYJJSsfeGSw51OlMV0OcrMYza97IBYgSn/jlthphw9NqfcZ9o
	 QqWbh/ZFsPowA==
Received: from localhost (c-71-229-227-126.hsd1.co.comcast.net [71.229.227.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CC52940423;
	Mon, 23 Feb 2026 21:34:09 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Costa Shulyupin <costa.shul@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: Costa Shulyupin <costa.shul@redhat.com>
Subject: Re: [PATCH v1] Documentation/rtla: Add hwnoise to main page
In-Reply-To: <20260215131249.33437-1-costa.shul@redhat.com>
References: <20260215131249.33437-1-costa.shul@redhat.com>
Date: Mon, 23 Feb 2026 14:34:09 -0700
Message-ID: <87v7fn401a.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Costa Shulyupin <costa.shul@redhat.com> writes:

> Add hwnoise to the command list and SEE ALSO section.  The command list
> is ordered from low level to high level.
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  Documentation/tools/rtla/rtla.rst | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied, thanks.

jon
