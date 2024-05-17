Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAD82E636;
	Fri, 17 May 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715941142; cv=none; b=MSg5YQZ3vXgyKfVhVCTe5zXYixt1BtNYoYPHs/WyG55rdLr1gKbeWER5aF1+CrH5nbN/4m2MTrQehiiGiwkn6OA2ZdxV9uFqqzMyCaMAb13asVPJuVs6tnrocftaj9O23xKQmDn7uSqj2vEm1R1yD+XU5oVZcpoS70W5fLgWOjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715941142; c=relaxed/simple;
	bh=Ev2QxGS+nYbwzvGq7dvuwAZN+qqi89Mpk5JkIVj85wI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jUrSx8SfwR+9J7OJzwFf3eiy/HNMLJRPNtbpW3SpScFYtCF7XwBTOjUlfAONDQJx6x5YxRNNwoH2+Q4NRNubdiKx9Ys4mTdV37iW7iXgPwQOcBDh14rBCvTRKxJFhDEZQT1/gtBrMNRWC9lYN9eop9D4z1zfAzrkyipCz0g8QQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2J9P/An; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2J9P/An"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D5BC2BD10;
	Fri, 17 May 2024 10:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715941141;
	bh=Ev2QxGS+nYbwzvGq7dvuwAZN+qqi89Mpk5JkIVj85wI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O2J9P/An142PttNMhiYSBtQn/7wv7KwaO2pU6C2D/Lk3U3VQG2oXzVQ3h0s40VvrC
	 D8j2sY93fvRCPzaXYWF8yXSCrwGfGyKuJHhBbhIvjDZ8SSfe9Fs1Id3mfw0zYOAm4g
	 ITtI00n/7xqXGtGtUE2fk8XPyQnyU/73OzdRhA/jO/YVY6vLUWTjd9X4P38zfA99E/
	 8AWrp0WU/mt5WlD2EmTZiqNOzJSp5nLP/nw9LQrKkR82FRdryV/p6EIaWN8mPdm7UZ
	 NT4fOyVS31q7ys3s54SjVWUR7VKP3arC4gLYvqyOpVmsMlXnlHJSZyIR9Dlywbi8eR
	 OUanComm1zTeg==
Message-ID: <4f7f992f-0c68-4760-ac9d-37a5c6c948cd@kernel.org>
Date: Fri, 17 May 2024 12:18:58 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] rv: Update rv_en(dis)able_monitor doc to match
 kernel-doc
To: Yang Li <yang.lee@linux.alibaba.com>, rostedt@goodmis.org,
 mhiramat@kernel.org
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240517091452.47703-1-yang.lee@linux.alibaba.com>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20240517091452.47703-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yang

On 5/17/24 11:14, Yang Li wrote:
> The patch updates the function documentation comment for
> rv_en(dis)able_monitor to adhere to the kernel-doc specification.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  kernel/trace/rv/rv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index 2f68e93fff0b..df0745a42a3f 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -245,6 +245,7 @@ static int __rv_disable_monitor(struct rv_monitor_def *mdef, bool sync)
>  
>  /**
>   * rv_disable_monitor - disable a given runtime monitor
> + * @mdef: Pointer to the monitor definition structure.

This change is in for mainline kernel, why are you using the -next on the Subject?

-- Daniel
