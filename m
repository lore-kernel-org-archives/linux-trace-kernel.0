Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB707367B9A;
	Thu,  2 Jul 2026 05:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782970047; cv=none; b=WrU1zERSKQxilsdTdGUGCb8BnLBbixwr1UWJazOgcgsq4ypNCmQNMT5pbIdmWobcSyNc2Nd2vDMW+CGAREPopZ9K5I+pVlrDZIQKMaKQMgM0P7fQRKL1dzSPtHh6hRmn4rP/BEAF+RHAT84X3/oFSF+mL7dOBJj2suHHAjAPgfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782970047; c=relaxed/simple;
	bh=WYDR0nQQ1bdl3MUtYKvzO6cTcuQ2+fkyJfr8u94NEJo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=J37wFTHjMJQqO+ei286HzcGw9oWxHbG5ZvblS2PqkNFwCl37eYpNwjzgfM3oBQoSFfm7azWZgDVHa5SomANIfQTgt8vdkG5ah+8W+/Nv7XWAsXtlnw/l/nNZM21kx+pnDNUkPPWoPxIBxHwBd+wfUkYda4e2xG8DqWCDPILqMcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iW6U1SrF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iW6U1SrF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF93F1F000E9;
	Thu,  2 Jul 2026 05:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782970042;
	bh=C08jKJ6czF3m0nwfNL9580hMVdmD6MmeDKsgUpPlyUQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iW6U1SrFEGDToeoRfh9ZTksJNRQGEavWuHdRCAHuV4G6G4Cn/qLLkYtckwmZgwgOl
	 Y3iLCnoB07UPwRPnvR2MuYo53YX7n6ue32cdXPgn1SzDDnm4+3B0nJhfjJr4DQ0/3K
	 VQeRJw0F3rjz7c63b6Qnv9vZiuviYrRrG74FWaDB1yv1gvcIJVMRs8zldp7OTJmQ5Z
	 JcZrirodr+1lNGLO2l6r9Ag583OEt5Tej+jAdwaC3E7KbCcnSnBoMh5duw6uDKG24U
	 5AqSMTDkRA9rgq9Cof18yT7fjr3WQsTg6C9AUqn8q0XDNKIYWpjx/eZtizuAZKa/VF
	 SDF91+lHxV0uQ==
Date: Thu, 2 Jul 2026 14:27:19 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: shuah@kernel.org, Wang Yan <wangyan01@kylinos.cn>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/ftrace: fix spelling error in poll test
 comment
Message-Id: <20260702142719.4e5f6ed1691c6dedaf2a0cd6@kernel.org>
In-Reply-To: <20260702015634.366201-1-wangyan01@kylinos.cn>
References: <20260702015634.366201-1-wangyan01@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Shuah, can you pick this through your tree?

Thank you,

On Thu,  2 Jul 2026 09:56:34 +0800
Wang Yan <wangyan01@kylinos.cn> wrote:

> Fix typo "happned" -> "happened" in ftrace poll test comment.
> 
> Signed-off-by: Wang Yan <wangyan01@kylinos.cn>
> ---
>  tools/testing/selftests/ftrace/poll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/poll.c b/tools/testing/selftests/ftrace/poll.c
> index 53258f7515e7..4da86a20dc85 100644
> --- a/tools/testing/selftests/ftrace/poll.c
> +++ b/tools/testing/selftests/ftrace/poll.c
> @@ -66,7 +66,7 @@ int main(int argc, char *argv[])
>  	}
>  	close(pfd.fd);
>  
> -	/* If timeout happned (ret == 0), exit code is 1 */
> +	/* If timeout happened (ret == 0), exit code is 1 */
>  	if (ret == 0)
>  		return 1;
>  
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
