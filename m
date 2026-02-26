Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F1F368955;
	Thu, 26 Feb 2026 22:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772143728; cv=none; b=GeNIMKmO4PETOy7DgfqOd5NSpMkDvWTg0wQxAEtj21vJS/NJQRbRAUeOlntjD8iQQ1orQFmFK2ftptjUVz3haHpzh/95IgzpQn0mY+OHX5ungiJMC+kjEN6gokdWef7f/4sLdEnONIuHifH9Hc6IL+OnLuIBInWdEaZvmo0T9So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772143728; c=relaxed/simple;
	bh=04u31OS8pHtQknBMGM0v9En/KT3xrx+KpMvq6UGaC9o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VNqlmB3GyMotpJhG2Z7tlaV3rO9/7h1KPTKwMCef47Vy5Hke+KuE/+mrsxNH3jup/2ZS6SPsDJd6IetUTy7UUpIWc/uiZblX85m6SiHS1yPy9YLOLjaaoGg8FBMLUhbiIUC2fYGgb0ByvZynZIW5KtJrijnOQFAq3S0cl+bjUdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wVuWoyEo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wVuWoyEo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C0CC116C6;
	Thu, 26 Feb 2026 22:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1772143727;
	bh=04u31OS8pHtQknBMGM0v9En/KT3xrx+KpMvq6UGaC9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wVuWoyEoWa6hkBNz5BZQM0u1SAhmT92KyWrGnw8SGD79sCKTc4r6NQlwSoVZiaOgg
	 waV04VNXIDDAh+3UainQ+sHa3dTPAzXIsMsjEE8YSQFUY5b0z20fICqwVsaL+XXCfw
	 UATodmqmOCaRws1NDXz98RFcrPgQql9TqEXQllak=
Date: Thu, 26 Feb 2026 14:08:46 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: kernel test robot <lkp@intel.com>
Cc: Dmitry Ilvokhin <d@ilvokhin.com>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie
 <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Brendan Jackman
 <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan
 <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>, Qi Zheng
 <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 oe-kbuild-all@lists.linux.dev, Linux Memory Management List
 <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 kernel-team@meta.com, Benjamin Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v3 4/5] mm: rename zone->lock to zone->_lock
Message-Id: <20260226140846.4d8b30f200b0194c4bb78d25@linux-foundation.org>
In-Reply-To: <202602270508.8MKXotxZ-lkp@intel.com>
References: <1221b8e7fa9f5694f3c4e411f01581b5aba9bc63.1772129168.git.d@ilvokhin.com>
	<202602270508.8MKXotxZ-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Feb 2026 05:48:05 +0800 kernel test robot <lkp@intel.com> wrote:

> Hi Dmitry,
> 
> kernel test robot noticed the following build errors:
> 
>    mm/shuffle.c: In function '__shuffle_zone':

yep, thanks.  And kernel/power/snapshot.c.  I've added fixups.
