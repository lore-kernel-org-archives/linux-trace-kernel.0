Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5587C4A1E;
	Thu,  8 Aug 2024 06:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723098019; cv=none; b=etmgsbsNE1F1EfHas3V2X+aYo/+GA7ItVp0gC8Lq4HSbG9mHnUK72tSbVlZxYrwaSg6/HOIt/jsR49Sjl0OubF9Y/wCRCoM5O2T4OoovnycWikH+vWUSkP58Uy9YWVVLb1S0YsmF1E6voowyf7yiusujXF0X6DtFLi70G3srKNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723098019; c=relaxed/simple;
	bh=X9NY6xCSLD4ufw4GmHD6bL7PfZlnwn442WiojDh1QoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEahqyYWxiwVAUCkgY3+Lx/dzUwPdn8L3cxyjjBofQ+wgR99n/pmSCAwDjIeT1i7gAXAwAz0atFE2Z6ZlhsbP/WIRbAAA6pVI0pAP3F56Kn3wZcdVmAJKhNc0A/JJW9Uywbi4rB87pfurpK3b7ddkWjk6hMZhKMhdiUUpVOBHwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFDQbhkL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFDQbhkL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C02DC32782;
	Thu,  8 Aug 2024 06:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723098019;
	bh=X9NY6xCSLD4ufw4GmHD6bL7PfZlnwn442WiojDh1QoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lFDQbhkLAPVrpBzMivRB3q1DQzO9myhdCHwfR5uOB2+84aQTZxFi1chGA60bZieRS
	 DaYksPM+Svo/5N6Nua0yXep112L3A/LQ4qVYn4+FjociZac/Ztb6is8UnjlvQV9LD1
	 Xiasj2u8DB2UO7dteo58gW47cMwLORmnEpRLYs/4Ro/+AHBWBM3N2uLFJxRitvocDn
	 AIams1FJMakx6yCSugubObtItgQ/3pLduNfsgeP/H3Ze5pm/owGXzSisZK1RDnkZuV
	 1teqHp6wzmwn0GbsnkEoR0jUNSK8rkNvRl8N0Qb5iuJrK/5J+4aSwCVFKWUxKZB9gB
	 x7v51oLnA+TDg==
Date: Thu, 8 Aug 2024 09:18:07 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] pstore/ramoops: Fix typo as there is no "reserver"
Message-ID: <ZrRi7fdYo3yVPr1G@kernel.org>
References: <20240807170029.3c1ff651@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807170029.3c1ff651@gandalf.local.home>

On Wed, Aug 07, 2024 at 05:00:29PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> For some reason my finger always hits the 'r' after typing "reserve".
> Fix the typo in the Documentation example.
> 
> Fixes: d9d814eebb1ae ("pstore/ramoops: Add ramoops.mem_name= command line option")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> Note, I did have this fixed, but the previous version was pulled:
>   https://lore.kernel.org/linux-trace-kernel/20240613233446.283241953@goodmis.org/
> 
>  Documentation/admin-guide/ramoops.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
> index 6f534a707b2a..2eabef31220d 100644
> --- a/Documentation/admin-guide/ramoops.rst
> +++ b/Documentation/admin-guide/ramoops.rst
> @@ -129,7 +129,7 @@ Setting the ramoops parameters can be done in several different manners:
>      takes a size, alignment and name as arguments. The name is used
>      to map the memory to a label that can be retrieved by ramoops.
>  
> -	reserver_mem=2M:4096:oops  ramoops.mem_name=oops
> +	reserve_mem=2M:4096:oops  ramoops.mem_name=oops
>  
>  You can specify either RAM memory or peripheral devices' memory. However, when
>  specifying RAM, be sure to reserve the memory by issuing memblock_reserve()
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.
