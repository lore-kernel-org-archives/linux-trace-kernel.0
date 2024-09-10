Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98A12AE69;
	Tue, 10 Sep 2024 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725983123; cv=none; b=JofxbkUuMFL7frJC+0whjwANDnUAc+EvbzCkfr2UuyI+5XNkjHSe8LLu7g+wNQQ8/h98hvGT9Xatszjt+nA0pHffOEkULQ28TJbKAhw+k7ZCOjE2QFUxPY/6Q2D7l9MHrzCzTI17rfkfzY/LDAo1Wb3cXzPioaq17AETIpE9I+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725983123; c=relaxed/simple;
	bh=wPW5UGXl4ccqRpNCgYnRNiaaJoiYpwD7Np5V/k1Z4tI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kN1NYeSa3WTZwmoBVa2lenFs9P5rGyCDpJrxPpMJKwROH6ez14ABdn7KJGel2UukO6F7SMKrPku9g4bZLe0KMNErv+1uwAXsiAiFFBF60pzINiTAPzJTqcPXM5CwPDor+qAbfhnqgf5AqV2JOzX84f7UxyqsSRUv8WqOPfefUKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A595CC4CECD;
	Tue, 10 Sep 2024 15:45:22 +0000 (UTC)
Date: Tue, 10 Sep 2024 11:45:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 0/2] ring-buffer/selftest: Meta-page testing
 improvements
Message-ID: <20240910114523.074ca67b@gandalf.local.home>
In-Reply-To: <20240910144323.2888480-1-vdonnefort@google.com>
References: <20240910144323.2888480-1-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 15:43:21 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> Following the comments on the original patch [1] here's a set of 2 patches to
> improve the selftest.
> 
> [1] https://lore.kernel.org/all/20240628104611.1443542-1-vdonnefort@google.com/

This looks good, but can you resend this and Cc:

  Shuah Khan <skhan@linuxfoundation.org>
  linux-kselftest@vger.kernel.org

Thanks,

-- Steve

> 
> Vincent Donnefort (2):
>   ring-buffer/selftest: Verify the entire meta-page padding
>   ring-buffer/selftest: Handle meta-page bigger than the system
> 
>  tools/testing/selftests/ring-buffer/map_test.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> 
> base-commit: 2fcd5aff92aab479a9a89cfce2dbc9c6a9455b4f

