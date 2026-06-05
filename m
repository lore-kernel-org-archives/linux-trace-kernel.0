Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACC640E8FF;
	Fri,  5 Jun 2026 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780668825; cv=none; b=deYDUqtzNPx1WQJuBIScL4pQdC3HSPizs4RF/R3DPPnDgH8BaQsZiNNN7T8cYGGqzsU4vdXnFgyKrMXbirwANwMx3XYU0/4xBr+lihDW/rtZFh7WH1WJTVOte3WBaKe5d690IMEbja7gVP9vHMoZAkXQB7caVRwzD43jjy91JXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780668825; c=relaxed/simple;
	bh=bU98HIRPthpNDJM5uR0akM5Kz5mqzk4XLNl22M9kIGM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=RD4eEuzhG5ho2zoUi2fD9ypxoQ1axrEdbKP+XIUFCQLswnm89CW/dnmdy+ZWWxvJVScxR2tD+eeMlcNk5NQnnd83Ro5ekG/jf5GcSwmile5/HHtKBVl8prtx6f+DiZf29CzoU5tE7kLUDmteRFqKE07ofW/r1KkvGwLQUSFKNWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id D0817A0142;
	Fri,  5 Jun 2026 14:13:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 42D172000E;
	Fri,  5 Jun 2026 14:13:33 +0000 (UTC)
Date: Fri, 05 Jun 2026 10:13:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
 "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
 "Luck, Tony" <tony.luck@intel.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
 "xieyuanbin1@huawei.com" <xieyuanbin1@huawei.com>,
 "Lai, Yi1" <yi1.lai@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mm/memory-failure tracepoint change breaks userspace rasdaemon
User-Agent: K-9 Mail for Android
In-Reply-To: <39cbb38f-ed3b-4f17-b9b7-ed466957ee99@kernel.org>
References: <CY8PR11MB7134346A3E4BB28ECA28D6E989132@CY8PR11MB7134.namprd11.prod.outlook.com> <b930678d-a1ae-458c-8705-7ca9680d4cb6@kernel.org> <20260603121707.7eccb9fb@gandalf.local.home> <20260603161947.GBaiBUI7C8WWPwD84S@fat_crate.local> <0c16bf3d-7c6d-4e28-b200-03b7d0ef714a@kernel.org> <20260603130006.7d2c4a62@gandalf.local.home> <b637ede2-73da-49f0-a7eb-70ec79e79624@kernel.org> <20260603153115.775a2e81@fedora> <39cbb38f-ed3b-4f17-b9b7-ed466957ee99@kernel.org>
Message-ID: <BF17A4D3-D408-43B6-A440-A49B94C7BB62@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 42D172000E
X-Rspamd-Server: rspamout01
X-Stat-Signature: jes9k5b7di1o6k3x7d97ihiq411ba4nt
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/62rHCtMuTCz6iX+3NT56GhQE8IV4VS4s=
X-HE-Tag: 1780668813-492527
X-HE-Meta: U2FsdGVkX1/PBkQrb/Jvh0066tdGux5w33fpB9sqGI7EaNk0BPMC/PFfoJmWddVH0E58lf5PW+o+Bwu9NZZAw+13Qa8el9ieLTZTrtp+Aq/BWP8EX8uiLqqtn8+BHfHnNtAg3Voe5W9IgUOCcIQoGqfof9mdVZeOd0UkeUv0CwbdXtTcIEWT/c3PGfcjT3z9O6CA9MaRx3KqMvbA8+gvTPvIBlSIYlhA6NNvghAMXrInx84xI+MMmylkeqjsn/o4DZAiKD1E0Y/8cPVHNzAGUBfIL/9ZAHEFOnMapjaQjm7/cn4Fg9b/NoixMHoCY9kQJjr0+U+FAjbpVtYST5Un7Gsd7BYt4XP6



On June 5, 2026 4:52:28 AM EDT, "David Hildenbrand (Arm)" <david@kernel=2E=
org> wrote:
>On 6/3/26 21:31, Steven Rostedt wrote:
>> On Wed, 3 Jun 2026 21:13:30 +0200
>> "David Hildenbrand (Arm)" <david@kernel=2Eorg> wrote:
>>=20
>>> Thanks, that makes sense!
>>>
>>> So, would it be fair to say that, in general, what's exposed through
>>>
>>> 	/sys/kernel/tracing/events/
>>>
>>> is stable ABI?
>>=20
>> It's only stable if something depends on it=2E It changes all the time=
=2E
>> It's only when someone complains about it that it becomes "stable"!
>
>Heh, so we only know that it's stable when we break it =2E=2E=2E
>
>Let me figure out how to document that=2E
>

Yep=2E That's basically Linus's rule=2E He even said we break user space A=
PI all the time=2E What we don't allow is to break actual user space=2E The=
 problem is that you can break user space by fixing an API without knowing =
something depended on the bug=2E
