Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77B942AAF;
	Fri, 19 Apr 2024 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713525258; cv=none; b=mopMSTnD7lzedqzWPjUhO0DL61uPd3AePI/t+XWm99jTArpWzP+wEo2pW+92NnCBFQjVtRvkzZlpXSR5eoEEJsfLjQAx6Km/KxBb40yxh33mzcCVWYbS9PkHPDbzbY6yKMiccscXSxoFVyy6fj7GF9IzoZKhyIyuATYvZskP6pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713525258; c=relaxed/simple;
	bh=ljb4AVkXcG7myBq4CTZK/BgzPpSb5kx8TuMxr6J4Nsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p489A+za1v6bGeNc7qZ5QZ48Yov3eLbSZEh0YLDV/giuyVq2Gt3ggLbNREoyAN4YCvqV+KSZTlZmekApU2FoiKltHaBx8rZIeS1VD7TfYCnKsfXzh8qGdnrmMay4WM1CEvGpXaxEINNZZZNpC/iHX7ccP7uTVwEzeUz9pdB/CIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n9H58hL6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n9H58hL6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F062C072AA;
	Fri, 19 Apr 2024 11:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713525258;
	bh=ljb4AVkXcG7myBq4CTZK/BgzPpSb5kx8TuMxr6J4Nsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n9H58hL6+4u5sX8pq6xDwIZ4J//Vd3OxcdSa6YafSXazVi+f9f6AaW1SHXMosGusg
	 ly4en4ocYMSeB3cD1C7yERCeoza7glfv398bG2a85kntPSyd6HHG3KIBRb043bl3qq
	 Lh29PtjYFeAQzQmBBs8E70p+eG37mT8qlfD144Es=
Date: Fri, 19 Apr 2024 13:14:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, stable@kernel.org
Subject: Re: [PATCH] Revert "tracing/trigger: Fix to return error if failed
 to alloc snapshot"
Message-ID: <2024041905-pristine-stimuli-6894@gregkh>
References: <20240418132806.159307-1-siddh.raman.pant@oracle.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418132806.159307-1-siddh.raman.pant@oracle.com>

On Thu, Apr 18, 2024 at 06:58:06PM +0530, Siddh Raman Pant wrote:
> This reverts commit b5085b5ac1d96ea2a8a6240f869655176ce44197.
> 
> The change has an incorrect assumption about the return value because
> in the current stable trees for versions 5.15 and before, the following
> commit responsible for making 0 a success value is not present:
> b8cc44a4d3c1 ("tracing: Remove logic for registering multiple event triggers at a time")
> 
> The return value should be 0 on failure in the current tree, because in
> the functions event_trigger_callback() and event_enable_trigger_func(),
> we have:
> 
> 	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
> 	/*
> 	 * The above returns on success the # of functions enabled,
> 	 * but if it didn't find any functions it returns zero.
> 	 * Consider no functions a failure too.
> 	 */
> 	if (!ret) {
> 		ret = -ENOENT;
> 
> Cc: stable@kernel.org # 5.15, 5.10, 5.4, 4.19
> Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
> ---
>  kernel/trace/trace_events_trigger.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Now queued up everywhere, thanks.

greg k-h
