Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AB537F735;
	Wed,  3 Jun 2026 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780515021; cv=none; b=UvJ2WXnW41LtpHzk5Ux9aAisGigay0QGwnIpVYFD+33TbqNICJZpXpbaOtUzRR/UNYclDp67+1DlN9fAplHd9pYzbEoHZloMdDQLfQazqfTHLpMyaf210Uu3BYe8aYzOEByOThuFxSLQo1xGPVr7vZkOrjxfB79mMTP/+eAbzro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780515021; c=relaxed/simple;
	bh=F69vsQeHbyoyMZVBd1vUWQkk0/OoQptaQ+XWtGiSedY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B82VknRBaeIEFe7PtlB1lfPr0qr33wUsGjLptnrVexaMBZtAnktKH+p3k9fUUK4uQuChaHDE1MZ7/L57kMuSaKjJ9TWpNcq5uOC2aA7dV9I8p7dAph6F51HkX+kS4rUzT5CSV788KgiAHmvAAispsXgsYm3tXdPN53475v3VDA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id B5CAE8CC90;
	Wed,  3 Jun 2026 19:30:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 77CD220030;
	Wed,  3 Jun 2026 19:30:13 +0000 (UTC)
Date: Wed, 3 Jun 2026 15:30:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
 "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>, "Luck, Tony"
 <tony.luck@intel.com>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
 "xieyuanbin1@huawei.com" <xieyuanbin1@huawei.com>, "Lai, Yi1"
 <yi1.lai@intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
 <linux-edac@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mm/memory-failure tracepoint change breaks userspace rasdaemon
Message-ID: <20260603153012.68a4ceaf@fedora>
In-Reply-To: <b637ede2-73da-49f0-a7eb-70ec79e79624@kernel.org>
References: <CY8PR11MB7134346A3E4BB28ECA28D6E989132@CY8PR11MB7134.namprd11.prod.outlook.com>
	<b930678d-a1ae-458c-8705-7ca9680d4cb6@kernel.org>
	<20260603121707.7eccb9fb@gandalf.local.home>
	<20260603161947.GBaiBUI7C8WWPwD84S@fat_crate.local>
	<0c16bf3d-7c6d-4e28-b200-03b7d0ef714a@kernel.org>
	<20260603130006.7d2c4a62@gandalf.local.home>
	<b637ede2-73da-49f0-a7eb-70ec79e79624@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 9ak3p9hedcp6mocfyrf6tw1d61i9oadi
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 77CD220030
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+Yc1+s+cpTaOQ67esXGNHrUDWcjq+NSXY=
X-HE-Tag: 1780515013-642169
X-HE-Meta: U2FsdGVkX18v7iMYUEW0g3+XMctZ0GI3DcZlcv/LKdYWui6sUi0y9Z+MHojHkeTRXkt3/B9P2leWl/d1Ou7gwWo15wnVZyYSdPzbToSltpamxuc+CAw3+8Wiiha9UQJLJoOuhdw8f8tIQ7ol0VDo6Hc+9rq/yUTrx785LNL07NO4xa6rxAE11vkCoIEHsGwJxZmzizgR4QhnhmqgVxsTkoLS1DONoiWmhgc3o1Ey5dRYmuIS7BpDGnY7ifHIzKf3YQyBLeQB6HwsYHtDe09n5rdbi+ou4K4icYMxalzv9hQkGsqmU2Nr88zht5FHEbd9yDqIRBOiGtH2YLoOsBzK1xf87TteaWrlPLze/QJkcUTCLeasBA9chQ==

On Wed, 3 Jun 2026 21:13:30 +0200
"David Hildenbrand (Arm)" <david@kernel.org> wrote:

> Would the following be sufficient to avoid a full revert and the dependency on CONFIG_RAS?
> 
> diff --git a/include/trace/events/memory-failure.h b/include/trace/events/memory-failure.h
> index aa57cc8f896b..c46b17602578 100644
> --- a/include/trace/events/memory-failure.h
> +++ b/include/trace/events/memory-failure.h
> @@ -1,6 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #undef TRACE_SYSTEM
> -#define TRACE_SYSTEM memory_failure
> +/* Some user space relies on ras/memory_failure_event */
> +#define TRACE_SYSTEM ras

If that puts back the original path then yeah, all would be good.

-- Steve
  

>  #define TRACE_INCLUDE_FILE memory-failure
>  
>  #if !defined(_TRACE_MEMORY_FAILURE_H) || defined(TRACE_HEADER_MULTI_READ)

