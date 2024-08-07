Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ADB155336;
	Wed,  7 Aug 2024 21:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067847; cv=none; b=C+JCmPTquyw+AoM9WAEJA/KeyiECvj+94eyqiISmotqdK5XgODzfOmy1UgFWypWGx00qukJmUsgZvVbXRWHnJOXUAw0xlnXxUfESh7R9eRz4M9kZU36j2g7GrRInsxHLfamc644s6OdheNIbJSkwdO5PrRs/KhJ/XZwrQq3KIfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067847; c=relaxed/simple;
	bh=ab42EY7AePAQAjjiN0FjmKz697SEyB0rVErEnmbUBY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g1xp3Ng6rk3U46Skh8B4bJasrqolWfAVrHvdUokUnBbI8E5tyErx09pQNNX2McshprgVHZ55ET5JqMQXNaBWqvCQVjQ699spIZOZS/rJWE8GWu+o050bHZTlm+3Ym96l9h51awgwyygLuVDze1kF0C+BqZgWa3/e7mU5UVzuphk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b89+P3kh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b89+P3kh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82502C32781;
	Wed,  7 Aug 2024 21:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723067846;
	bh=ab42EY7AePAQAjjiN0FjmKz697SEyB0rVErEnmbUBY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b89+P3kh2B7Idb0H9qgYUXh+1gIGIdwOPnNvhriOXfNvZXNJEzgvsAkKQLVyYZB6y
	 Ub14NXI5zmEr7X86he1OSMEewOnMCjjAO5mJ7kCPcHcHsFQOMLVPbQHAj/8HZcuI9f
	 MZYsxDcUt73IOFrJYV7RguWhJQ3J9PX85Zlt1D+hlwlWxJRPGpJITTFtdFOgBzYWaZ
	 xcCjyLNWc5DPix+/I53lS1hkrqnt5LKHP0CdjDVYEmNOfY4NeCHQ5XYl6w54zjwTjk
	 dkU350YZlHcsxx1u2uCR23pMExi+C13By1rnydam7mxhO6MhfHJsDaQO6UbeL50diP
	 n091XFNSyqaZg==
From: Kees Cook <kees@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] pstore/ramoops: Fix typo as there is no "reserver"
Date: Wed,  7 Aug 2024 14:57:21 -0700
Message-Id: <172306784057.66923.16977092081545994826.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807170029.3c1ff651@gandalf.local.home>
References: <20240807170029.3c1ff651@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 07 Aug 2024 17:00:29 -0400, Steven Rostedt wrote:
> For some reason my finger always hits the 'r' after typing "reserve".
> Fix the typo in the Documentation example.
> 
> 

Applied to for-next/pstore, thanks!

[1/1] pstore/ramoops: Fix typo as there is no "reserver"
      https://git.kernel.org/kees/c/08043b1dabf8

Take care,

-- 
Kees Cook

