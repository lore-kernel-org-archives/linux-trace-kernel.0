Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5988B1ABC25;
	Thu,  4 Jul 2024 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102406; cv=none; b=lw7J6DOEKwzF5rZPW4KMVKA+zOX4rHOZ26T4p2l+Ik68AOQ1KEKjoT0T1hgxZHhlG5ZsWEUaUd1CUioUpyL8urv58AIM++JSQ2JzxjCFcKZz8AKE+BkkZoQ+7zw3zANY2SD6YhYOyaBIt7QruELPv6NRJiiSj9qvNNdkjm7j0l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102406; c=relaxed/simple;
	bh=Kxp53RpKhzP/mT97Uo4HoDiVi6oQPPrL2VvGUnRSWXo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8sqLl/jYtiYnLfQqYri2VCp3iiH/+ZTiEfqOkTd6c/Z9aVTFs5tWRdqPUf3XwkYLvNyTCxb0eoOS6d17SmkMiXGoSVF86wOAi7OYWh7qWaeTsE5OyKAEAgJEIwLcT+k2YkBZpZh1QxVBDLrZFWJeZumdN2L7JyZxQ4ylXbyYbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5346C3277B;
	Thu,  4 Jul 2024 14:13:24 +0000 (UTC)
Date: Thu, 4 Jul 2024 10:13:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Matthew Wilcox <willy@infradead.org>, Hongbo Li <lihongbo22@huawei.com>,
 muchun.song@linux.dev, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hugetlbfs: support tracepoint
Message-ID: <20240704101322.2743ec24@rorschach.local.home>
In-Reply-To: <Zoab/VXoPkUna7L2@dread.disaster.area>
References: <20240704030704.2289667-1-lihongbo22@huawei.com>
	<20240704030704.2289667-2-lihongbo22@huawei.com>
	<ZoYY-sfj5jvs8UpQ@casper.infradead.org>
	<Zoab/VXoPkUna7L2@dread.disaster.area>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jul 2024 22:56:29 +1000
Dave Chinner <david@fromorbit.com> wrote:

> Having to do this is additional work when writing use-once scripts
> that get thrown away when the tracepoint output analysis is done
> is painful, and it's completely unnecessary if the tracepoint output
> is completely space separated from the start.

If you are using scripts to parse the output, then you could just
enable the "fields" options, which will just ignore the TP_printk() and
print the fields in both their hex and decimal values:

 # trace-cmd start -e filemap -O fields

// the above fields change can also be done with:
//  echo 1 > /sys/kernel/tracing/options/fields

 # trace-cmd show
# tracer: nop
#
# entries-in-buffer/entries-written: 8/8   #P:8
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
            less-2527    [004] ..... 61949.896458: mm_filemap_add_to_page_cache: pfn=0x144625 (1328677) i_ino=0x335c6 (210374) index=0x0 (0) s_dev=0xfe00003 (266338307) order=(0)
            less-2527    [004] d..2. 61949.896926: mm_filemap_delete_from_page_cache: pfn=0x152b07 (1387271) i_ino=0x2d73a (186170) index=0x0 (0) s_dev=0xfe00003 (266338307) order=(0)
     jbd2/vda3-8-268     [005] ..... 61954.461964: mm_filemap_add_to_page_cache: pfn=0x152b70 (1387376) i_ino=0xfe00003 (266338307) index=0x30bd33 (3194163) s_dev=0x3 (3) order=(0)
     jbd2/vda3-8-268     [005] ..... 61954.462669: mm_filemap_add_to_page_cache: pfn=0x15335b (1389403) i_ino=0xfe00003 (266338307) index=0x30bd40 (3194176) s_dev=0x3 (3) order=(0)
     jbd2/vda3-8-268     [005] ..... 62001.565391: mm_filemap_add_to_page_cache: pfn=0x13a996 (1288598) i_ino=0xfe00003 (266338307) index=0x30bd41 (3194177) s_dev=0x3 (3) order=(0)
     jbd2/vda3-8-268     [005] ..... 62001.566081: mm_filemap_add_to_page_cache: pfn=0x1446b5 (1328821) i_ino=0xfe00003 (266338307) index=0x30bd43 (3194179) s_dev=0x3 (3) order=(0)
            less-2530    [004] ..... 62033.182309: mm_filemap_add_to_page_cache: pfn=0x13d755 (1300309) i_ino=0x2d73a (186170) index=0x0 (0) s_dev=0xfe00003 (266338307) order=(0)
            less-2530    [004] d..2. 62033.182801: mm_filemap_delete_from_page_cache: pfn=0x144625 (1328677) i_ino=0x335c6 (210374) index=0x0 (0) s_dev=0xfe00003 (266338307) order=(0)


Just an FYI,

-- Steve
