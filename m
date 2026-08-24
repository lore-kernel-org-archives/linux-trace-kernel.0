Received: from mta0.migadu.com (out-231.mta0.migadu.com [91.218.175.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C9D3A1E8C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787559188; cv=none; b=NQEZ9ElrUdy668Dhkgt/hNoE38QH6Jrchpg2a4AzoVszUwlXV7tayNqkHBfsH3fcjrsJBRhLADDwvADzSp3Y16vY8HN6ai4pYX754KnNFjsbYd3fqKKS1Qu6K1mun6C0LvjWU/atYhCxf1qm3UuX6uN2UWORN2ypfenJSPuC/m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787559188; c=relaxed/simple;
	bh=IVeVPbKL49TCH2itDpGWCx8+AacsU4ms6FDLHw/oas4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=F+cxzxKxwraWEKs/rX0swBEe4Fo6qA4wqX5nAq+AZfhL3ZGnAhikYrHOsFqii3/fnZOkz+r5w3SR8qfGKqHAyB4iUub7yxI63Bgh2BvNZFpdwVtr7tXPD5BpYQOXjW9SlSbaHTIWXLo+jqWtWMuAyWa2d9o5g1YDoVQLhW3kUNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D64uBYFF; arc=none smtp.client-ip=91.218.175.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D64uBYFF"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=IVeVPbKL49TCH2itDpGWCx8+AacsU4ms6FDLHw/oas4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787559183; v=1; x=1788163983;
 b=D64uBYFFU4XpP33tb6/GlRXBwpFZIcWCQ7zIRVvZktmyso8yaditLPs0T7sN4ptGVpE/Nggo
 94WDo1o9YUOk45Ug7pJmUy/icIkUEiRMYAXQD5WVCEiFoElhQoyefrc6hOy8rGCTf18+6+ZNRah
 4AveuR10o5CcXfabOHBqNqcs=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: from smtpclient.apple (114.251.196.97)
	by mta12.migadu.com with ESMTPS id 03a5a03ad4541403;
	Mon, 24 Aug 2026 08:13:02 +0000
X-Mizu-Trace-ID: 03a5a03ad4541403
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH 5/6] userfaultfd: decouple fault reason from VMA flags
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260823-uffd-vm-flags-v1-v1-5-3086981b33cf@kernel.org>
Date: Mon, 24 Aug 2026 16:12:41 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Barry Song <baohua@kernel.org>,
 Dev Jain <dev.jain@arm.com>,
 Hugh Dickins <hughd@google.com>,
 Jann Horn <jannh@google.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 John Hubbard <jhubbard@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Lance Yang <lance.yang@linux.dev>,
 "Liam R. Howlett" <liam@infradead.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michal Hocko <mhocko@suse.com>,
 Nico Pache <nico.pache@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 Pedro Falcato <pfalcato@suse.de>,
 Peter Xu <peterx@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Usama Arif <usama.arif@linux.dev>,
 Vlastimil Babka <vbabka@kernel.org>,
 Zi Yan <ziy@nvidia.com>,
 linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CB35D894-1B3B-4D48-BCEF-38BB091F65FF@linux.dev>
References: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org>
 <20260823-uffd-vm-flags-v1-v1-5-3086981b33cf@kernel.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)



> On Aug 23, 2026, at 20:17, Mike Rapoport (Microsoft) <rppt@kernel.org> =
wrote:
>=20
> Introduce enum uffd_reason to define reasons for user faults rather =
than
> overload VM_UFFD_* VMA flags for that.
>=20
> Using a dedicated enum makes the code clearer and decoupling the fault
> reason from VMA flags clears the way for moving the uffd mode bits out
> of VMA namespace.
>=20
> No functional change.
>=20
> Assisted-by: copilot:claude-opus-4.6
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Acked-by: Muchun Song <muchun.song@linux.dev> # for HugeTLB.

Thanks.

