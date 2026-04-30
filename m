Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A880334D4E2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Apr 2026 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777540630; cv=none; b=XGlMSCn5hLaw9FxkXwbXHx+mJZjtirK4twfJPJfkuWyIBW62ZkD3XMN/ephm0D/RI9ug2GTUoMAY3ibcaVTp4XJrCIQ+nc+bl6zgL+rZNdSW5yajyLXJ2zRi7yVgFSPOQWfIY60woSWKrkPykoS4QQTCR5VxzaLsJe2jcOEp6bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777540630; c=relaxed/simple;
	bh=zASkZpDnp0HKO3Di+BYa06DeuxEaSIIb9mLPGirXHSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VHN19JbXl6/cLanWj1x2WlZgVVXsXdjC342YLeCGJgnBl3RBOUhV11dQI4N56uomSUN8s2foHuH2UzeNuNc1PJfPtkxeEXg1KbVWuRBrc+ZZGIyAllHqp5AhfpwJ1CKv0Aj2TTj5ECOGzrmyF/sNfVJ44UjfRgtmAKVy1vZYlmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGh05/7U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGh05/7U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777540627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zASkZpDnp0HKO3Di+BYa06DeuxEaSIIb9mLPGirXHSA=;
	b=YGh05/7U9KnnR3DdfLPh4i/ZH2WLhUnGAwFlpbAdPujlAz3s30CYD6Tx9C82mBsjuTulW3
	/TByb4V4gJDpIwDDkzXg+uKUA2IAtnleihwLfhGdbGZed5SXOz/y5ls1a/VXHAjZ3VtGcc
	eFuGMXrFp9So8tFMOIbJ4feh1C3WHnI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-jvU-4sD1M2-nzrBsuwhr_w-1; Thu,
 30 Apr 2026 05:17:04 -0400
X-MC-Unique: jvU-4sD1M2-nzrBsuwhr_w-1
X-Mimecast-MFC-AGG-ID: jvU-4sD1M2-nzrBsuwhr_w_1777540621
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E4C01800358;
	Thu, 30 Apr 2026 09:17:00 +0000 (UTC)
Received: from fedora (unknown [10.44.48.22])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 48D911800480;
	Thu, 30 Apr 2026 09:16:51 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 30 Apr 2026 11:17:00 +0200 (CEST)
Date: Thu, 30 Apr 2026 11:16:50 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Daniel Walker (danielwa)" <danielwa@cisco.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Darko Tominac -X (dtominac - GLOBALLOGIC INC at Cisco)" <dtominac@cisco.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	"xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/madvise: preserve uprobe breakpoints across
 MADV_DONTNEED
Message-ID: <afMeAs6upm8kLCYb@redhat.com>
References: <20260429131522.4049054-1-dtominac@cisco.com>
 <889e4186-9f75-45d3-bd9a-1c90b218a635@kernel.org>
 <afIiqR5CqYRId0N0@redhat.com>
 <afJz3l6435DHLorn@goliath>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <afJz3l6435DHLorn@goliath>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: A2PlSR3Y97LSyyTUVOMBJFUUOEl8Pk6o7-3At45oo3Q_1777540621
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 04/29, Daniel Walker (danielwa) wrote:
>
> Shouldn't there be some sort of compensation or notification for this, or is each person that
> hits this suppose to just scratch their head and send a patch that's rejected?

Not sure... uprobes assumes that it owns the modified page and nobody
can modify/unmap it, including the probed application or debugger.

But may be MADV_DONTNEED should not set zap_details.even_cows == true
by default ?

Oleg.

