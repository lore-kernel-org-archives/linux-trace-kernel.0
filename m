Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A3329E11B;
	Fri, 28 Nov 2025 21:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764366227; cv=none; b=lJjxaGGd3rl0+k3NkPwQ9EJDQhnQHRs6XOFoBaW5297H9iTDMDviQwa0l9mu09xbCNtRT+wrzSgjRtj8I9tPCWtt1bYS7Ktw5j6r8sNcGntP6DpF7u5ZCobhVFvD7xVC9FNsfHT3mqvl2GYpp2CFtd53Y0eqZctQbP7dA5Rg0X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764366227; c=relaxed/simple;
	bh=vgzvdWY2s7thIWmMsPgHy/ia72rjlLdT6JPpZtj7IFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJpGzjzzwkcWKood/pYwpCsyulNXacS5XWMQzaABHFiAZK44Xnibca/9QL0ACebhWyE75xFh8IJ9Psn1tQ9KhFkJRsIVlJmQLunBiuPhfS3+ZC2bzQqCMXaJ35ysa5FkvyOx1R6F6kbuBAcunW07MC3qdbU6WvW1Uf8b4aacG/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DNZ06xUx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DNZ06xUx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=qBrHXWwtUB7b8fk+im24xdBt7pvQvBtNmMwKjLkVxhU=; b=DNZ06xUxWf6BSN/EXGMTg1Pa3Y
	CZHipD2rqSGD4O785scwDXaYmjO23pPNqKfYI5WYjRj5elql6G60n/JrgNn7BpPuYVKa8BocLP/Co
	DWNdYilx+NfYUrs2XmmNA2hqo79HgHx5QWDVA3iW3RC9h+L2fB4vI3b9UcAXIH+nC5Q8G7+hyx/Tx
	TbinWbZLUjJZN3+vCDAksNYzyBuoErZLSBIa3SezK6DAX6XmsQwZzC9xZ3TodQBCb/c5VieGzUoY7
	qCDTvaYfo1KdbwHtcWerq+v9yWDPoPh290ebCRrE6MpX0x9LFNEcBh8OaAtP2OIcYRX7608udl8um
	9uQgk30g==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vP6Fh-00000000z8t-2S6G;
	Fri, 28 Nov 2025 21:43:41 +0000
Message-ID: <68a739f3-5484-4846-b87f-94a7ce306e43@infradead.org>
Date: Fri, 28 Nov 2025 13:43:41 -0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: tools/rtla: remove undefined substitutions
 in common_options.rst
To: Sameeksha Sankpal <sameekshasankpal@gmail.com>, rostedt@goodmis.org,
 corbet@lwn.net
Cc: linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251128151838.7985-1-sameekshasankpal@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251128151838.7985-1-sameekshasankpal@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/28/25 7:18 AM, Sameeksha Sankpal wrote:
> The RTLA common options documentation uses several Sphinx substitution
> placeholders (|threshold|, |tool|, |thresharg|, |tracer|, |actionsperf|)
> that are not defined anywhere in the tree. This causes the htmldocs
> build to fail with multiple "Undefined substitution" errors.
> 
> Replace these undefined substitutions with plain text or generic
> placeholders (<tool>, <threshold-option>, <tracer>) to ensure the
> documentation builds cleanly while preserving the intended meaning of
> the examples.
> 
> Signed-off-by: Sameeksha Sankpal <sameekshasankpal@gmail.com>
> ---
>  Documentation/tools/rtla/common_options.rst | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/tools/rtla/common_options.rst b/Documentation/tools/rtla/common_options.rst
> index 77ef35d3f831..bd5a6f32f5bf 100644
> --- a/Documentation/tools/rtla/common_options.rst
> +++ b/Documentation/tools/rtla/common_options.rst

Does this patch apply to the mainline (Linus) kernel?
This is already fixed in linux-next or docs-next.
You should usually check -next trees for fixes like this.

See:

commit 96b546c241b1
Author: Gopi Krishna Menon <krishnagopi487@gmail.com>
Date:   Mon Oct 13 16:27:20 2025 +0700
    Documentation/rtla: rename common_xxx.rst files to common_xxx.txt

Thanks.
-- 
~Randy

