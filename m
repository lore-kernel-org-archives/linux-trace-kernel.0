Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D2DC6FD1C
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 22 Mar 2023 10:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjCVK07 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 22 Mar 2023 06:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjCVK06 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:26:58 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098A760402
        for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:26:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54476ef9caeso182352197b3.6
        for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679480808;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MtH1n9QiA63gGMjEpHqesA6wudB34zsYwX818Sy5m4A=;
        b=lGv1/rRD+5FbA1Y5PSY7SSYcajL+DOt5PFDatW40TMfBdbo9L0x7kjG/PbiS4kuCyQ
         jASqtZVX6caArqed/337xNw+VyMYGknWzwDT4eR3rlPDHmjmbUT0NlETlHyZ4SN//7nv
         mC6iasTMkhGk1vDmMzpqsSNWmMy2VTTfXosIcO+/JUPVwcJaHIM27fVwfObXNAZyTfwG
         5WrzbHXhWF8TcODAs7DPs38d5phDGrtvmVHaVyAggmGwMQv+vixJMCOgCpKi5mEBsWzU
         Won6p/mArEqYGbjxf1JEqYE8cDVM99sgqivTDQXX9co4I2pkTU0e1jAu34ic1Ty8Wbid
         GP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679480808;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MtH1n9QiA63gGMjEpHqesA6wudB34zsYwX818Sy5m4A=;
        b=wHOTiX4B70w3HbCyOK5xqB9Crmd7K7sSfKKH2+JuVdOWPF68WK7GYSJ1ASXa+QOcww
         /uGX7+g5PlejrZjccHVJwuAfU/LAYISB4dNIsJADzrLVKjL9zzp59pz1wjzCpThAwb6w
         LXAugsCzdaUS9REe51KP6mmUjr302wrA1jJ9SgVTK9vdTVeaA3sM5Za985wSmAOEjY4/
         oByKgsnRJhYk+o5VNgIM36ofuY9pfWwD6TM1rU4WlPh3SkCKAguhlHHT73hdDqfc3hv/
         LGdoYMTnwCRMwz4VCiafwd7sffM6n8SLL/C7m0GVVhsYxTk/SBxGMM/solO3nltsZhAx
         XfjQ==
X-Gm-Message-State: AAQBX9ec5FIpLq1zpberX7DFvihfBT6w3Ejej8HF6ozhnwug9u6s9GoQ
        U/HbjSSZgS24ehmo8JwULG7+KaydbP0QMZvw
X-Google-Smtp-Source: AKy350akULjauXYO0Sq/02BHUZWdetu1cc2nH40DZ94CwYFG+U5GgSeRwyVD+01kGzfjbykadDsxqs82DUwsHk5w
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6902:1503:b0:af7:38fc:f6da with
 SMTP id q3-20020a056902150300b00af738fcf6damr1104197ybu.2.1679480808284; Wed,
 22 Mar 2023 03:26:48 -0700 (PDT)
Date:   Wed, 22 Mar 2023 10:22:42 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230322102244.3239740-1-vdonnefort@google.com>
Subject: [PATCH v2 0/2] Introducing trace buffer mapping by user-space
From:   Vincent Donnefort <vdonnefort@google.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

The tracing ring-buffers can be stored on disk or sent to network without any
copy via splice. However the later doesn't allow real time processing of the
traces. A solution is to give access to userspace to the ring-buffer pages
directly via a mapping. A piece of software can now become a reader of the
ring-buffer, and drive a consuming or non-consuming read in a similar fashion to
what trace and trace_pipe offer.

Attached to this cover letter an example of consuming read for a ring-buffer,
using libtracefs.

Vincent

v1 -> v2:
  * Hide data_pages from the userspace struct
  * Fix META_PAGE_MAX_PAGES
  * Support for order > 0 meta-page
  * Add missing page->mapping.

Vincent Donnefort (2):
  ring-buffer: Introducing ring-buffer mapping functions
  tracing: Allow user-space mapping of the ring-buffer

--

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <signal.h>
#include <errno.h>
#include <unistd.h>
#include <tracefs.h>
#include <kbuffer.h>
#include <event-parse.h>

#include <asm/types.h>
#include <sys/mman.h>
#include <sys/ioctl.h>

#define TRACE_MMAP_IOCTL_GET_READER_PAGE	_IO('T', 0x1)

struct ring_buffer_meta_page_header {
        __u64   entries;
        __u64   overrun;
        __u32   pages_touched;
        __u32   meta_page_size;
        __u32   reader_page;    /* ID of the current reader page */
        __u32   nr_data_pages;  /* doesn't take into account the reader_page */
        __u32   data_page_head; /* ring-buffer head as an offset from data_start */
        __u32   data_start;     /* offset within the meta page */
};

/* Need to access private struct to save counters */
struct kbuffer {
	unsigned long long 	timestamp;
	long long		lost_events;
	unsigned long		flags;
	void			*subbuffer;
	void			*data;
	unsigned int		index;
	unsigned int		curr;
	unsigned int		next;
	unsigned int		size;
	unsigned int		start;
	unsigned int		first;

	unsigned int (*read_4)(void *ptr);
	unsigned long long (*read_8)(void *ptr);
	unsigned long long (*read_long)(struct kbuffer *kbuf, void *ptr);
	int (*next_event)(struct kbuffer *kbuf);
};

static char *argv0;
static bool need_exit;

static char *get_this_name(void)
{
	static char *this_name;
	char *arg;
	char *p;

	if (this_name)
		return this_name;

	arg = argv0;
	p = arg+strlen(arg);

	while (p >= arg && *p != '/')
		p--;
	p++;

	this_name = p;
	return p;
}

static void __vdie(const char *fmt, va_list ap, int err)
{
	int ret = errno;
	char *p = get_this_name();

	if (err && errno)
		perror(p);
	else
		ret = -1;

	fprintf(stderr, "  ");
	vfprintf(stderr, fmt, ap);

	fprintf(stderr, "\n");
	exit(ret);
}

void pdie(const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	__vdie(fmt, ap, 1);
	va_end(ap);
}

static void read_page(struct tep_handle *tep, struct kbuffer *kbuf,
		      void *data, int page)
{
	static struct trace_seq seq;
	struct tep_record record;

	if (seq.buffer)
		trace_seq_reset(&seq);
	else
		trace_seq_init(&seq);

	while ((record.data = kbuffer_read_event(kbuf, &record.ts))) {
		kbuffer_next_event(kbuf, NULL);
		tep_print_event(tep, &seq, &record,
				"%s-%d %9d\t%s\n", TEP_PRINT_COMM,
				TEP_PRINT_PID, TEP_PRINT_TIME, TEP_PRINT_NAME);
		trace_seq_do_printf(&seq);
		trace_seq_reset(&seq);
	}
}

static int next_reader_page(int fd, struct ring_buffer_meta_page_header *meta,
			    struct kbuffer *kbuf)
{
	int prev_reader_page = meta->reader_page;

	if (ioctl(fd, TRACE_MMAP_IOCTL_GET_READER_PAGE) < 0)
		pdie("ioctl");

	return meta->reader_page;
}

static void signal_handler(int unused)
{
	printf("Exit!\n");
	need_exit = true;
}

int main(int argc, char **argv)
{
	int page_size, meta_len, data_len, page, fd, start = -1;
	struct ring_buffer_meta_page_header *map;
	struct kbuffer *kbuf, prev_kbuf;
	struct tep_handle *tep;
	__u64 prev_entries;
	void *meta, *data;
	char *buf, path[32];
	int cpu;

	argv0 = argv[0];
	cpu = atoi(argv[1]);
	snprintf(path, 32, "per_cpu/cpu%d/trace_pipe_raw", cpu);

	signal(SIGINT, signal_handler);
	tep = tracefs_local_events(NULL);
	kbuf = tep_kbuffer(tep);
	page_size = getpagesize();

	fd = tracefs_instance_file_open(NULL, path, O_RDONLY);
	if (fd < 0)
		pdie("raw");

	meta = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
	if (meta == MAP_FAILED)
		pdie("mmap");
	map = meta;
	meta_len = map->meta_page_size;

        if (meta_len > page_size) {
                munmap(meta, page_size);
                meta = mmap(NULL, meta_len, PROT_READ, MAP_SHARED, fd, 0);
                if (meta == MAP_FAILED)
                        pdie("mmap");
                map = meta;
        }

	printf("entries:	%llu\n", map->entries);
	printf("overrun:	%llu\n", map->overrun);
	printf("pages_touched:	%u\n", map->pages_touched);
	printf("reader_page:	%u\n", map->reader_page);
	printf("nr_data_pages:	%u\n\n", map->nr_data_pages);

	data_len = page_size * (map->nr_data_pages + 1);

	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED, fd, meta_len);
	if (data == MAP_FAILED)
		pdie("mmap data");

	page = ((struct ring_buffer_meta_page_header *)meta)->reader_page;
again:
	do {
		kbuffer_load_subbuffer(kbuf, data + page_size * page);

		if (page != start) {
			printf("READER PAGE: %d\n", map->reader_page);
		} else {
			kbuf->curr = prev_kbuf.curr;
			kbuf->index = prev_kbuf.index;
			kbuf->next = prev_kbuf.next;
			kbuf->timestamp = prev_kbuf.timestamp;
			kbuffer_next_event(kbuf, NULL);
		}

		prev_entries = map->entries;
		start = page;

		read_page(tep, kbuf, data, page);
	} while ((page = next_reader_page(fd, meta, kbuf)) != start);

	prev_kbuf.curr = kbuf->curr;
	prev_kbuf.index = kbuf->index;
	prev_kbuf.next = kbuf->next;
	prev_kbuf.timestamp = kbuf->timestamp;

	while (prev_entries == *(volatile __u64 *)&map->entries && !need_exit)
		usleep(100000);

	if (!need_exit)
		goto again;

	munmap(data, data_len);
	munmap(meta, page_size);
	close(fd);

	return 0;
}


 include/linux/ring_buffer.h     |   8 +
 include/uapi/linux/trace_mmap.h |  28 +++
 kernel/trace/ring_buffer.c      | 384 +++++++++++++++++++++++++++++++-
 kernel/trace/trace.c            |  76 ++++++-
 4 files changed, 490 insertions(+), 6 deletions(-)
 create mode 100644 include/uapi/linux/trace_mmap.h

-- 
2.40.0.rc1.284.g88254d51c5-goog

