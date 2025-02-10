Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEECB2586D6
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Feb 2025 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216300; cv=none; b=A/fmVwDElRcKbBG+G1R950DRAZa9fr5X8rt7qd5zorEw4DNLtNcgraXexcOB7iZ8rbcR52JCZEyuZi39h98OaKU6b+tNzNBq0/VhkaKqO5rpnAYRIuNH2MvURqOUZEKUuZjb+wVCK+Cf4c0VWGxnLDTEIHqgePcvAdO6VXgghJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216300; c=relaxed/simple;
	bh=Xaxds3jkrAWo/nPRt6XArpsBiXLgWRUTYm/DhS1e3Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=kYa35VVzc2TtUSFIOmoGhVB0nAr+xUHIFyiuhuKiXOUPEeyhUjtOTVqCykz0+TSZfpsxONalhnm/scN7FIqrZ5V298mbEVqY4Tu+6z03E1bZCEF6+rCqaIvscltPyIUPnxiRwHDmRfAupJj8VYdWH8WsEOqILc/JS++LiEaeb7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PvAMsqFV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PvAMsqFV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqeXk3kyzFMqBsxEiyyOZegmX6HzmCNZGUJC3XQma+8=;
	b=PvAMsqFVqyLFimvCSyLi25m+PfFuhxxh7sQCbk7oBX/IZRsF/mA/OaixvocvpWHxkt0/jj
	uN4N5Ed4hb27y3wYZgS8gbxhGg/DrnxDnTt61OIqJVDA7zDdbLHrUP8LZaodkH4s5s6JCl
	5Zk5iBgbWId32Js+IxueQOM7lYR3b80=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-GK5n9PnLPVOHk-LGqqapmg-1; Mon, 10 Feb 2025 14:38:14 -0500
X-MC-Unique: GK5n9PnLPVOHk-LGqqapmg-1
X-Mimecast-MFC-AGG-ID: GK5n9PnLPVOHk-LGqqapmg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4394b8bd4e1so3393065e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Feb 2025 11:38:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216293; x=1739821093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqeXk3kyzFMqBsxEiyyOZegmX6HzmCNZGUJC3XQma+8=;
        b=TpDvBHQioVPilDbDeTcJLjW7X0GOQRnaK+il+PKWnH8soqGACCQQ5QvQR6F4XYv6Sd
         BH1AB0HIzG8sy4bNl5l/AubwF72d4lt0+2aMyf6xs7FVt4l5NREH1Hoq+OXAv18Meliq
         QFMFv3HGX0t2hPZVoRjpRTnPNrB9B1dFz6ZvSLqp2PdG3s7LfXdmDgTXy7z/swIoymf3
         iENCjcHr8/BkF9aJnDREOumMTS0tXrWqst8x3NX49KP8cFxxFePAh3V6un6MaxQ+ptyR
         vx3aeVNIgmOWA+mMMtdEt55QA3vWvEDAzJMsf9b7bAADmocUvG3UxTFL/R2hlagTGWNX
         G5zg==
X-Forwarded-Encrypted: i=1; AJvYcCXxyFEohebOXC/QYbY5Mec+WvElYIqgx1MaHOOOYk7J5aGvkRmxdEoiGUhRDg2Zv6RciMufUY7B2W2Xvdnk9ECv2lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ZE64OHZdsv+uXeML6TchcGQp0lEXFHRP7mQATbJBGKtqwGUS
	De4VDv4vNmEQqs0vlQUbRY9T78CsyN8Ac9h2F5vsofJ3yfgc9jrtvwELMIEkui2w8T3nBZpRJZh
	whBdPsQnLPXlfSnbQhxpKxpNKtib9wcpr5TdCHcfKplmwU0qPHPCaAkSeCkPIJajcSYcpsA==
X-Gm-Gg: ASbGncslalUQsWb+E28ZQoDxOiEuwlleE3CpMEb5PeREBbhW1bN5wuy9urCcylbe3v+
	RWC5Mx9LX/MllYMo5mf4N4SYf22dfm5F4NdFVJMT1dXu9vhQqhJJXCJ6+lp5R/f31QByppIBXrO
	T9OgANhMOQOljvuaroq56ppQDP4/T04Cc+F9YFPF8z9WlllBBHdpc00Scs/1fJZBc3iwT2pfIG9
	lBKgVhqhyu7lU7yES9YlVZDByRJxh+ivL4VNR3MjuV+6LssCt2dt+peHLzlEUON/47w8dqvagt8
	JDFvKpXvIYO3ey0dFnw3giptu2ngxjZaY4YRs7bO5xod0sXc5vgJKMezgZcnJPWHtQ==
X-Received: by 2002:a05:600c:34c4:b0:439:4b9e:461b with SMTP id 5b1f17b1804b1-4394b9e47dfmr21358185e9.14.1739216292949;
        Mon, 10 Feb 2025 11:38:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFz4p8WiTgagZxwnDzZ7MmocZCF9a1hUwQMJIvxH3cH5x6X+HJSMDirq9gM71FmkI7KhAXcpA==
X-Received: by 2002:a05:600c:34c4:b0:439:4b9e:461b with SMTP id 5b1f17b1804b1-4394b9e47dfmr21357855e9.14.1739216292555;
        Mon, 10 Feb 2025 11:38:12 -0800 (PST)
Received: from localhost (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43947bdc5c4sm26937995e9.23.2025.02.10.11.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:38:11 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org,
	nouveau@lists.freedesktop.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	damon@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Peter Xu <peterx@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 02/17] mm/rmap: reject hugetlb folios in folio_make_device_exclusive()
Date: Mon, 10 Feb 2025 20:37:44 +0100
Message-ID: <20250210193801.781278-3-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210193801.781278-1-david@redhat.com>
References: <20250210193801.781278-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jLIh7yzMAYYvEd0bT2Q8velbiO2xu9Qkvxw6KvJMhIo_1739216293
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Even though FOLL_SPLIT_PMD on hugetlb now always fails with -EOPNOTSUPP,
let's add a safety net in case FOLL_SPLIT_PMD usage would ever be reworked.

In particular, before commit 9cb28da54643 ("mm/gup: handle hugetlb in the
generic follow_page_mask code"), GUP(FOLL_SPLIT_PMD) would just have
returned a page. In particular, hugetlb folios that are not PMD-sized
would never have been prone to FOLL_SPLIT_PMD.

hugetlb folios can be anonymous, and page_make_device_exclusive_one() is
not really prepared for handling them at all. So let's spell that out.

Fixes: b756a3b5e7ea ("mm: device exclusive memory access")
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index c6c4d4ea29a7e..17fbfa61f7efb 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2499,7 +2499,7 @@ static bool folio_make_device_exclusive(struct folio *folio,
 	 * Restrict to anonymous folios for now to avoid potential writeback
 	 * issues.
 	 */
-	if (!folio_test_anon(folio))
+	if (!folio_test_anon(folio) || folio_test_hugetlb(folio))
 		return false;
 
 	rmap_walk(folio, &rwc);
-- 
2.48.1

