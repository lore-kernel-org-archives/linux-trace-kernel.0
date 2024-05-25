Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618EC138C;
	Sat, 25 May 2024 02:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716604460; cv=none; b=oZ+25fFyg7ZbTsD1brC4Si55RutvtkHRoyUQbILw3K4XV0pPtuOnMurPuKXx0BQhKIZE/yao4x7y/TzeThYP2dzKC6XeL+wDKQI046ppUCZo2/r9r3XXlYdLdtqhl1saENCb3x6OxZh41kS2rneHE7XRWLR4E4FUlRWZcWkviEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716604460; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Message-ID:Date:From:To; b=aGCuZ03X+v6C+5YQMbDAkUk8fbBiqAiEB5+ClUqQM94mMeGLN8iUGR/z0bZd0OIjcOZ/X6Y3UoPPgvu+iulIYS6LW2XT5Gk50fiY6dhM7WRX/+qhBkiFh3qJy9rRz7ou93orfIcB/t1eiRkFYGfX8SwuBmtNIuYAREdZ/469L1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D19C3277B;
	Sat, 25 May 2024 02:34:20 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sAhFU-00000007D6M-1ndk;
	Fri, 24 May 2024 22:35:08 -0400
Message-ID: <20240525022947.793281895@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 24 May 2024 22:29:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

