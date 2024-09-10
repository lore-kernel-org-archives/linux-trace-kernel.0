Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316B619E7E0;
	Tue, 10 Sep 2024 16:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725986698; cv=none; b=sCiDTr/KyWRdgbL9MTf4lqhWkHiBWIh1hEUkeWH+0oSZxA9yKTkpqLJCmGGo1o5U7AdrSfzKuR7CQkT1ytyZ2Wq6FPQXLupDvp0V8aIMfzp3NzknPeXIa4QZ4ik6HTDlfyUgRHh083XbP1t+GJzrZVTACq5ACyy6fTGqVowJKGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725986698; c=relaxed/simple;
	bh=Hu/xfal5jORgsX+d60ZC4my7Jofu095bzy3b4vdL56M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UAFYiTIwnJftzokHT7tjjSmIlIb41rlovHlMgV87ozvnG87ubcHXa5U+qoFXNyCrJtLrJeG5/so4aHNB/RC42Dgw7qbK4FTJtFjPvpQhG6ejG7w5pigjxWhWBxaEbRWmUfYYItu1GoEhhSvwclrsmf1IEz3yNwXAyUn8Ie2G4X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08957C4CEC3;
	Tue, 10 Sep 2024 16:44:56 +0000 (UTC)
Date: Tue, 10 Sep 2024 12:44:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH RESEND 0/2] ring-buffer/selftest: Meta-page testing
 improvements
Message-ID: <20240910124458.207c6924@gandalf.local.home>
In-Reply-To: <20240910162335.2993310-1-vdonnefort@google.com>
References: <20240910162335.2993310-1-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 17:23:33 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> Following the comments on the original patch [1] here's a set of 2 patches to
> improve the selftest.
> 
> [1] https://lore.kernel.org/all/20240628104611.1443542-1-vdonnefort@google.com/
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

Ah, you just Cc'd the patches. OK, I can work with that.

-- Steve
