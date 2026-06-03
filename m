Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F2348BD50;
	Wed,  3 Jun 2026 19:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780515082; cv=none; b=uwnokaIVT6WbfhRbpmkijTDGcpZKQmwQprkTfpR4OABNgxBn9FS8zjC+8lLEKboJcdgoLby1ZmWfayr8r4DskXo6R3QQPpqK3zaSTcOnC3KyufM9SIFLps6mCsjpx2kA8sn7+rjq83c1OVyhsjOr0YUwgeCou+JUHfdGkT/xx4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780515082; c=relaxed/simple;
	bh=ghz5Ao/R3783Y4B+gTuiTMUjoiR3S9f3sQ4hfNeCR0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jURxIT6G//E4j59mqY6qsIL8wnQYbkVvNrOSPYklm4sWSdZDnnbxdst/KPUYFElhEQKpr5UTcJ3XIZVScNCmkBjqndVRsuSiirRRzaaQSoZ20Jd1LVCU/T2ns3wG6+ZttFSzLAX6aYpOoJv7z38D37cs33NUwfd2SoDS+aNsJd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 16F391C1CDE;
	Wed,  3 Jun 2026 19:31:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 27B732000E;
	Wed,  3 Jun 2026 19:31:16 +0000 (UTC)
Date: Wed, 3 Jun 2026 15:31:15 -0400
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
Message-ID: <20260603153115.775a2e81@fedora>
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
X-Stat-Signature: o1f9my7jggg5tdygakhbm7htic98hmto
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 27B732000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/v0JHug/fbEKbv0orzjsUgwqRSLAY4vfI=
X-HE-Tag: 1780515076-808314
X-HE-Meta: U2FsdGVkX18BS9WmFzYjXx1SEgGMWf6ubjVVWbxkrHXl/C+lfZyc1FY5NNDejF5/51RLVOu+dyiJyjXjGytmVlyD1dWzEqVx8QPcGtHRFRiiRsyVy2Wtj76dNjs0RLmjT3iRXEsS1MmRyxB7krYMay3dclmABmdtxLRZV7tgf3WNWNPrdJVjjREN04OTrq6wzDiPoWYZWgo90MB8u/h03etMedxCUVxuZECAyJ62EsifSXsgfsVLy6kYpM97IojMM0WdtYKJpWL45s6pRsNDuG9f1KzWfE5OTet3P61DSAP2jKGHj0jLFR9EXA2i9GjQSZmvuxbGiLUwCvieWoWn7+Pc2srt4cAY

On Wed, 3 Jun 2026 21:13:30 +0200
"David Hildenbrand (Arm)" <david@kernel.org> wrote:

> Thanks, that makes sense!
> 
> So, would it be fair to say that, in general, what's exposed through
> 
> 	/sys/kernel/tracing/events/
> 
> is stable ABI?

It's only stable if something depends on it. It changes all the time.
It's only when someone complains about it that it becomes "stable"!

-- Steve
