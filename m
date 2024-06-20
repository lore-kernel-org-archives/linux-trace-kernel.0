Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F46A19DF88
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873450; cv=none; b=JHs7KSr5Tqm/3M1h6ZCTDoumj1s3aXK/zBcnKwAHr1yFe28Dz2DMfkjlysmDAzJIbqo8wpZxt/tsHqIP9lqz7ZFfiW9cdxqZkQXTxGv/viTiyGrvGLkKZlNEnx5tEbozYUgf1tgw26vu0VJ1shIJc87XG6naVJiZb1Six1d/gdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873450; c=relaxed/simple;
	bh=J8AlTzn2cuj5/AsWL16JdZQs7eEzAqoaqJbZsGynG6s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q9boHp8SIvQhDRNR1fTGegtA2/WmP3Ivbm8uQ9+fJpbXnVad0VEnDlq17ThdMH0O8H2bGqdA8WkiPpNvMk9NBMQVPqlqdBVSzTwhDhBCVzbgYSCDhn8RVzRlepXDUbJtRapFwBEHNbJ/3yiNVi6SHqYkXKnNUJateqB1U0Qtyes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zzqcxyRN; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zzqcxyRN"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57ccd1111aeso633160a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718873447; x=1719478247; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dISpUGJA38EuaCw6NEc2rJ6Reirv0G1941aI36CtMEE=;
        b=zzqcxyRN8Ag2jhqDSy5jIZEfKCiBJjlwrAyd+ZX+CmCRqkEEBnGq+oO8T8yICRaNW9
         ZbuhLwmZSei2a97HN8OqllF8Z8WOylnd/s+CavEyYUQoN8g34FGpaWAJpWv0u+jSM7vB
         7WPde1utDoVgwBfP/E37dxK+GDLmCfKyLaHSjeQE7pSC3FKVQ8Mfj2GPYxxlnlfXLrI4
         umvPcEfh29XXL9l1MZdWjOGxhEEoGZlap+eJwFqo89AI94t6zkQ7VI6/YPYU0udXagCS
         k0hcJ71VOaKLv4Fcs/dncB/EQLJKnev8j05/mOtPa5I+3ZgPMJULbyCBq6qO4oJKjwjz
         XzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718873447; x=1719478247;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dISpUGJA38EuaCw6NEc2rJ6Reirv0G1941aI36CtMEE=;
        b=UoCU9m0Ly+Z2gwwast6bk66kbkTP5dKxCwZHi1TyNaCv4faL/NEBw6xRJ/rkob11NQ
         1KUC+PRqo1SURDJSQSltN1yYjBPRNhk1VQfffU2733AjQasLDyqiukYXtKMZm5ioNrfL
         OSixSlCiu8FLKSEN+RJGvn7MKpMxQVLwUFuZi/BkQNKs7aR14kkUmfTz49HszdKpPb+H
         NMUCkDiLEuO8UH5Gg6JzRLUj9/m05tDoHbsGpmy4YIaU2DKZKczAWlW32TdTxYSM72M8
         OON5XJXI5vCH8IpWlxl7lR6fEU89YfEH4eh1msWGSaqeYe4um51qBpYzK1L49oMYwmpR
         cIkw==
X-Gm-Message-State: AOJu0YxqeC0Rdbe2BpkjZnDwAIWEN55EHco4jW3Xj0F1ZwDuw+LCqMod
	OL0RbT2wL1XctGtJdh44S8GJKQSUilUm47ir9sa+8etInnPOZui8d4ZovVyAdCY=
X-Google-Smtp-Source: AGHT+IFYCMyxttsDKcVr+qJocF1z1eWvhmn7UsF9WLdJbxR0GAPuIpFhweTWRsaCmmWDU67Q+OgbXA==
X-Received: by 2002:a50:d6c2:0:b0:57c:aac9:cd6 with SMTP id 4fb4d7f45d1cf-57d07e27370mr2542832a12.4.1718873446653;
        Thu, 20 Jun 2024 01:50:46 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cddba1b0esm5167951a12.84.2024.06.20.01.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 01:50:46 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:50:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org
Subject: [bug report] ring-buffer: Validate boot range memory events
Message-ID: <e1f7e29a-0350-40c6-a28d-e9012f9a6428@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Steven Rostedt (Google),

Commit 5f3b6e839f3c ("ring-buffer: Validate boot range memory
events") from Jun 12, 2024 (linux-next), leads to the following
Smatch static checker warning:

	kernel/trace/ring_buffer.c:1824 rb_meta_validate_events()
	error: uninitialized symbol 'head_page'.

kernel/trace/ring_buffer.c
    1751 static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
    1752 {
    1753         struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
    1754         struct buffer_page *head_page;
    1755         unsigned long entry_bytes = 0;
    1756         unsigned long entries = 0;
    1757         int ret;
    1758         int i;
    1759 
    1760         if (!meta || !meta->head_buffer)
    1761                 return;
    1762 
    1763         /* Do the reader page first */
    1764         ret = rb_validate_buffer(cpu_buffer->reader_page->page, cpu_buffer->cpu);
    1765         if (ret < 0) {
    1766                 pr_info("Ring buffer reader page is invalid\n");
    1767                 goto invalid;

head_page is uninitialized

    1768         }
    1769         entries += ret;
    1770         entry_bytes += local_read(&cpu_buffer->reader_page->page->commit);
    1771         local_set(&cpu_buffer->reader_page->entries, ret);
    1772 
    1773         head_page = cpu_buffer->head_page;
    1774 
    1775         /* If both the head and commit are on the reader_page then we are done. */
    1776         if (head_page == cpu_buffer->reader_page &&
    1777             head_page == cpu_buffer->commit_page)
    1778                 goto done;
    1779 
    1780         /* Iterate until finding the commit page */
    1781         for (i = 0; i < meta->nr_subbufs + 1; i++, rb_inc_page(&head_page)) {
    1782 
    1783                 /* Reader page has already been done */
    1784                 if (head_page == cpu_buffer->reader_page)
    1785                         continue;
    1786 
    1787                 ret = rb_validate_buffer(head_page->page, cpu_buffer->cpu);
    1788                 if (ret < 0) {
    1789                         pr_info("Ring buffer meta [%d] invalid buffer page\n",
    1790                                 cpu_buffer->cpu);
    1791                         goto invalid;
    1792                 }
    1793                 entries += ret;
    1794                 entry_bytes += local_read(&head_page->page->commit);
    1795                 local_set(&cpu_buffer->head_page->entries, ret);
    1796 
    1797                 if (head_page == cpu_buffer->commit_page)
    1798                         break;
    1799         }
    1800 
    1801         if (head_page != cpu_buffer->commit_page) {
    1802                 pr_info("Ring buffer meta [%d] commit page not found\n",
    1803                         cpu_buffer->cpu);
    1804                 goto invalid;
    1805         }
    1806  done:
    1807         local_set(&cpu_buffer->entries, entries);
    1808         local_set(&cpu_buffer->entries_bytes, entry_bytes);
    1809 
    1810         pr_info("Ring buffer meta [%d] is from previous boot!\n", cpu_buffer->cpu);
    1811         return;
    1812 
    1813  invalid:
    1814         /* The content of the buffers are invalid, reset the meta data */
    1815         meta->head_buffer = 0;
    1816         meta->commit_buffer = 0;
    1817 
    1818         /* Reset the reader page */
    1819         local_set(&cpu_buffer->reader_page->entries, 0);
    1820         local_set(&cpu_buffer->reader_page->page->commit, 0);
    1821 
    1822         /* Reset all the subbuffers */
    1823         for (i = 0; i < meta->nr_subbufs - 1; i++, rb_inc_page(&head_page)) {
--> 1824                 local_set(&head_page->entries, 0);
                                    ^^^^^^^^^
Uninitialized

    1825                 local_set(&head_page->page->commit, 0);
    1826         }
    1827 }

regards,
dan carpenter
