Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618B710E6;
	Sat, 25 May 2024 02:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716604460; cv=none; b=iWT2hIH6n7f0rETV0uyj7M5k7OVuDXcdaNAh6/xj8rS8vKH7L/fowO0NVJvJ91N9un322tjLWBHtDJ8RY3XTUmTWi0fK/8X/C2VTAog8fAiE1xfqDIrjrImZ6KRaT9UyGBSJ9pRX30wB6v2H7mKn60rtCfd/U+bcxut3L1AG5XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716604460; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Message-ID:Date:From:To; b=QvIC2lolH5nDfqdnjNfW2zJ8L4m3LYJnxHbsjpzh1O9ezxLRxCe++weaa24AWiftfZL+oUqzajYY2dlCgF9HKfFnwve1IANLBCIInM3XfLRtCGJ0l8wRXG/QrZvx/b2mwcR2kRhIeBChtJKVWs7E0ANazk5fXwlf5IOvyytw4EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A42C2BBFC;
	Sat, 25 May 2024 02:34:19 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sAhFU-00000007D6r-2UvS;
	Fri, 24 May 2024 22:35:08 -0400
Message-ID: <20240525023508.458244953@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 24 May 2024 22:29:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

