Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898993;
	b=oMOmJOnwqGwFq4/Xa8hfxiIBswqJEN+/H493vEFQUnY7+O3WjMf+B0ekLA9MjKQnPu/N
	 +OkwITtPMgEKhxBM8/ua15Wcnds0ncEF9dDYBsGZ1Bp3bu1LRqH9DSVeL31ppERz7A/fy
	 iuqKiGXNul55VNiO4VkcUokbLtTIZl4CYcEWSMDSsSRV+Mrec1vDYBojgDNhxb1U3yZaP
	 p7Klo6DhsT65cgk4yD2EpjZoMmsnRqSIGGD5qo8AGgZPUspXGTzppOwnPQGB+QxZf9Y4/
	 1KNyu+zJgCUmaifHgUZmYol3tCtMe4aZZx9ZcumFzcha0d2CvjP8OaTNFhXwzQ0594Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898993;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=ESR01hVfCK1gp7i8nW8yl8a1SOvyJZG5i7j+b3mjIrY=;
	b=32pwemxUizoRJ0rZpKgHVpS88lFtQ+fv2GBqBjvpDl3yvSo3+pKnRheMzwTIOXGpyXba
	 BhOqHdAvyo5UAevVntramBzlSsfFzLGask6rWvDdoP9Tw1b9ldg/eEVTniFjAn2+1j3Ek
	 KA4NvNPUKadVKe+Zxy5bFcL6bMzDei57/WO6NW5S4YJrme5Z7xhXql+fAUTVMktoTQOiM
	 8QFvdthoSK+XryYehC2v1PnJhYXmcAg7YG8wy7jrx1laX9bNTOqvaOMLOVFFTbjzd88q9
	 olGmI5B4v7T3FHkktZLf51oyvVHP1qkhmxoi6F/J6KoG5wPPvrme0cpPsa7m7HUv1qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.50
Received: from esa3.hc555-34.eu.iphmx.com (esa3.hc555-34.eu.iphmx.com [207.54.77.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B930606A330;
	Thu,  5 Nov 2026 17:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B930606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1793898999; x=1825434999;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ovadr4aQgfWIah4NDeZK3wouRVsN9xHwGwefizVmO4U=;
  b=HPQHc6rWoPDXRhcQT2L/Dqv7tkh8Q2h34f7gpwOJ/GjAOCyUTvPelzIV
   +VocVgMqz+ugRMDDBmQALmFQTOtEh17vHw2w7z1N4/b6Nf/w6KeMiNQDd
   9Q7xVW48BHIa1YzzAF0y9OQqkAnDAGMlsCRheve2DfPVeSiX1tTtwflOF
   M363cHpK5uwB+4ztQlWS3Y0hRp2KRNqK/JCh+9BG3Esvc4hWwH467yY3C
   k7BfUZoBnC+QVCNKSierDCecYLS1ztEI2Aq8WljaJK3K5MqEtHmKEYsTQ
   50sAmflbpsjhjAB87HtB4TjFVc5caGzOBMmqcRnoscCeWyHo8NIn1YgAD
   g==;
X-CSE-ConnectionGUID: k6QzcMJsStKTIHBSOZ6+Nw==
X-CSE-MsgGUID: kwj54falRBCr5j7Wl1442w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 19:16:37 +0200
X-CSE-ConnectionGUID: 1sizQpTBSQ6izphpk93T/A==
X-CSE-MsgGUID: CNcNhsHTS/Kt4pRyFB1dUQ==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.2])
  by ces04_data.me-crop.lan with SMTP; 05 Nov 2026 19:24:26 +0200
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Thu, 05 Nov 2026 19:16:28 +0200
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Thu, 05 Nov 2026 19:15:24 +0200
Subject: [PATCH RFC v3 03/14] i2c: core: add helper functions for transfer
 report generation
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-i2c-fault-reporting-v3-3-515ad74ac4c9@mobileye.com>
References: <20261105-i2c-fault-reporting-v3-0-515ad74ac4c9@mobileye.com>
In-Reply-To: <20261105-i2c-fault-reporting-v3-0-515ad74ac4c9@mobileye.com>
To: Andi Shyti <andi.shyti@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Dmitry Guzman <Dmitry.Guzman@mobileye.com>, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.16.0

Add three helper functions for I2C transfer report generation:

- i2c_transfer_report_init() that puts -EOPNOTSUPP in all struct fields
  (this should be used if the defailed reporting is not supported);

- i2c_transfer_report_success() that is used to generate the report in
  success case (all messages are transferred successfully);

- i2c_transfer_report_bad_msg() that is used if one of messages cannot
  be transferred and no data were actually transferred.

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 include/linux/i2c.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index bf7dc12f7264..9bee726592fc 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -601,6 +601,27 @@ struct i2c_algorithm {
 #endif
 };
 
+static inline void i2c_transfer_report_init(struct i2c_transfer_report *report)
+{
+	report->msgs_cplt = -EOPNOTSUPP;
+	report->fault_msg_idx = -EOPNOTSUPP;
+	report->bytes_cplt = -EOPNOTSUPP;
+}
+
+static inline void i2c_transfer_report_success(struct i2c_transfer_report *report, int num)
+{
+	report->msgs_cplt = num;
+	report->fault_msg_idx = num;
+	report->bytes_cplt = 0;
+}
+
+static inline void i2c_transfer_report_bad_msg(struct i2c_transfer_report *report, int i)
+{
+	report->msgs_cplt = 0;
+	report->bytes_cplt = 0;
+	report->fault_msg_idx = i;
+}
+
 /**
  * struct i2c_lock_operations - represent I2C locking operations
  * @lock_bus: Get exclusive access to an I2C bus segment

-- 
2.43.0

